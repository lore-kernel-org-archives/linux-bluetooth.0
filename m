Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Two second pending connection timeout prevents connection to devices with long advertising interval
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <29147022-D6EA-4FEA-866C-4F296879FEBC@metanate.com>
Date: Thu, 1 Sep 2016 07:04:24 -0700
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@intel.com>
Message-Id: <91B9DFD1-C4E4-4E95-9053-7737F0ED61E7@holtmann.org>
References: <B0B1991C-FD3E-4E08-9641-DE745A6EC690@metanate.com> <9942937A-4799-4AA2-9551-8FEBF110550B@holtmann.org> <D938EDFC-0164-4B3D-86C6-DAC2FE269367@metanate.com> <2A4D0751-61E7-430F-BEE5-9254A6D8E7CC@holtmann.org> <29147022-D6EA-4FEA-866C-4F296879FEBC@metanate.com>
To: Northfield Stuart <stu@metanate.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stu,

>> The problem here is that we have to make this fly without harming any other user of the system. One peripheral should not block all the rest. And the problem here is really the re-connection time of for example a HID device where low-latency is what counts.
> 
> Understood.
> 
>> One solution would be to keep the long timeout with HCI_LE_Create_Connection if we have controllers that allow us to keep scanning. Meaning a combination of Passive Scanning State and Initiating State. This is something we need to find out with trial and error and see if it can be done.
>> 
>> As a background here. Currently we stop scanning when we see a device we need to connect to, then connect to it. And if there are other devices on the "to be connected" list, we enable scanning after successful or failure of the connection attempt.
> 
> Presumably this is per controller rather than global across controllers? One thing I forgot to mention is that some of our infrastructure code is capable of using multiple BLE controllers and (I guess due to the above) we usually keep one controller scanning while using the other(s) for connections. (NB I personally didn’t write any of this linux application code - I was merely tasked with investigating the 2s connection attempt termination issue.)

in Linux every controller / radio is treated independently. For all I care you can attach 64k to a system. That is really the only limit :)

I mean in theory we can always go with a super long timeout. However if the controller supports passive scanning and initiating state at the same time, we should use it. Limited controllers are limited. That's just it. If they are supporting it, then we should use it to make it low-latency if possible.

>> Essentially you want to change this into this:
>> 
>> a) Found device we want to connect to
>> b) If more devices are on the auto-connect list, keep scanning, other disable scanning
>> c) Send connect request and wait for its completion
>> d) For the first 2 seconds that connect attempt is exclusive
>> e) After that cancel it if we see another auto-connect device and try that device
>> f) Start over
>> 
>> Similar things then apply to when to re-enable scanning after connection termination, but I doubt that will actually have to change.
>> 
>> What this means in simple term, only disable background scanning when the auto-connect list empty. Otherwise keep it active and let the controller deal with the two instances of state machines by itself.
>> 
>> Now we need to check if that would work or not. We have quirks like HCI_QUIRK_SIMULTANEOUS_DISCOVERY and this might need another one. Not sure if we want to go with blacklist or whitelist here. I would do blacklist and actually check the supported states. Since this is LE only, the controller should not lie to us.
>> 
>> If you want to work on this, then try this simple approach:
>> 
>> a) Read the supported states and extract support for passive scanning + initiating
>> a) Use a long timeout
>> b) Only disable scanning when no other device is left on auto-connect list
>> 
>> If this basically works, then the only other thing we have to do is be smart about concurrent connection. Meaning that a long running one can be cancelled and replaced with something we see in the 2-x second window. As I said above, the 0-2 second window should be exclusive to the first attempt. We can tune these values, it is just the 20 second one is killing low-latency reconnect by HID device.
>> 
>> However there is one case to be made that we might only consider direct advertising to be able to interrupt it. Which would satisfy the HID requirement with low-latency. The advantage here is that they are high duty cycle and would show up right away. So you are not really losing out on your slow-connection attempt.
>> 
>> But this idea really stands and falls with the passive scanning + initiating state support in the controller.
> 
> OK - I’ll investigate the controllers we have (we are using at least two different chipsets I believe, possibly three) and then have a go at this simple test - probably won’t be before next week at the moment (trying to get a new release candidate out at the moment) and it might take me a day or two to re-familiarise myself and get to grips with the code :)

I took a random Broadcom dongle of the shelf and it seems to actually do fine with imitating state + passive scanning.

Btw. this is your main entry point to look at:

        /* If controller is scanning, we stop it since some controllers are
         * not able to scan and connect at the same time. Also set the
         * HCI_LE_SCAN_INTERRUPTED flag so that the command complete
         * handler for scan disabling knows to set the correct discovery
         * state.
         */
        if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
                hci_req_add_le_scan_disable(&req);
                hci_dev_set_flag(hdev, HCI_LE_SCAN_INTERRUPTED);
        }

        hci_req_add_le_create_conn(&req, conn);

It is not as easy as just adding extra checks around it. There is a bit more logic that needs handling. Mainly since just disabling scanning is not going to do it. You actually need to update the white list. So now the fun part is that if you can update the white list while scanning or do you need to stop scanning, update the white list and then restart scanning.

I wonder if we should start using hci-tester to some new tool (via HCI User Channel) to allow us do a quick check on what the controller supports.

Regards

Marcel

