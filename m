Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Two second pending connection timeout prevents connection to devices with long advertising interval
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <D938EDFC-0164-4B3D-86C6-DAC2FE269367@metanate.com>
Date: Wed, 31 Aug 2016 12:19:18 -0700
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@intel.com>
Message-Id: <2A4D0751-61E7-430F-BEE5-9254A6D8E7CC@holtmann.org>
References: <B0B1991C-FD3E-4E08-9641-DE745A6EC690@metanate.com> <9942937A-4799-4AA2-9551-8FEBF110550B@holtmann.org> <D938EDFC-0164-4B3D-86C6-DAC2FE269367@metanate.com>
To: Northfield Stuart <stu@metanate.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stu,

>> the problem is that in order to send a CONNNECT_REQ, the HCI_LE_Create_Connection command needs to see connectable advertising packet one more time. So the longer time you give to HCI_LE_Create_Connection to find it, the longer everything else in the system is blocked. Since only one HCI_LE_Create_Connection can be running at the same time.
> 
> We understand that, but for reasons which I’ll explain below, I suspect our only realistic option is a method of controlling this from our applications, not by modifying system behaviour automatically based on the device.
> 
>> Now if the peripheral in question would actually include ​«Advertising Interval» AD type in its advertising, then we could automatically adjust the scan window/interval and timeout when connection to such a device. Can you run a btmon trace and show the advertising data you are getting.
> 
> It’s a nice idea, but I can tell you now that the advertisement data from the device consists of purely the flags and manufacturer specific data fields filling the entire advertisement frame. There is no remaining space in the advertisement frame to add the advertising interval field! I can’t omit the flags field because the device is BLE only, thus some flag bits must be set.
> 
> This product is pushing at the boundaries of what is achievable. Without disclosing the exact nature of the product, it is a portable device equipped with screen, environmental sensors (temperature, accelerometers, etc), GPS, cellular modem, UHF transceiver and BLE (the Nordic BLE device acts as the system main processor as well). The requirement is for a (non-rechargeable, non-replaceable) battery life of 15 years (on average), potentially out in remote field locations for long periods of time. Naturally, physical battery space is limited too. It is an extremely challenging project, and the onerous battery life requirements have forced us to squeeze every last bit of data in to the adverts to minimise the requirements for connections. It was rather an unpleasant surprise to discover that moving development of the infrastructure tools forward to a later distribution/kernel stopped them working completely!
> 
> I’m sure you can appreciate that while I agree your suggestion is almost certainly the ‘proper’ solution to this issue, almost any solution which requires modifying the device behaviour has a severe impact on the power budget. For example, I could put the advertising interval field in a scan response, but enabling scan responses guarantees more time spent transmitting and a corresponding reduction in battery life.

Scan responses are not going to help here either. Since background scanning is passive scanning. We do not want to add to the mess that is active background scanning. That some phone OSes are doing this is already bad enough.

> Unfortunately, we will not be in a position to build bespoke patched kernel images for every linux platform expected to interact with these devices (some, yes, but I believe the COTS linux tablets will be out of our control), so we were really looking for a solution which would allow use of a modern distribution/kernel but still allow interoperability with a device such as ours by configuring or tuning the central behaviour from our bespoke applications.
> 
> At the moment the linux platforms in use on product trials are still running an early enough kernel that the issue is not affecting the trials, but it would be unrealistic to expect this to remain the case going forwards.
> 
> Any other suggestions? 
> 
> It’s a while since I worked on Linux kernel level stuff (I’m mostly embedded/OS X/iOS at the moment), but if it would be considered for inclusion then I’m prepared to put the effort in to a patch to provide some form of tunability around the timeouts (suggestions and guidance on preferred mechanisms welcome). We are in an environment where all the devices are ‘slow’ and we both understand and accept the implications of such a stack reconfiguration.
> 
> If it’s likely to be rejected out of hand, then that makes life considerably more tedious and we will have to have a serious re-think on how we move forward :(

The problem here is that we have to make this fly without harming any other user of the system. One peripheral should not block all the rest. And the problem here is really the re-connection time of for example a HID device where low-latency is what counts.

One solution would be to keep the long timeout with HCI_LE_Create_Connection if we have controllers that allow us to keep scanning. Meaning a combination of Passive Scanning State and Initiating State. This is something we need to find out with trial and error and see if it can be done.

As a background here. Currently we stop scanning when we see a device we need to connect to, then connect to it. And if there are other devices on the "to be connected" list, we enable scanning after successful or failure of the connection attempt.

Essentially you want to change this into this:

a) Found device we want to connect to
b) If more devices are on the auto-connect list, keep scanning, other disable scanning
c) Send connect request and wait for its completion
d) For the first 2 seconds that connect attempt is exclusive
e) After that cancel it if we see another auto-connect device and try that device
f) Start over

Similar things then apply to when to re-enable scanning after connection termination, but I doubt that will actually have to change.

What this means in simple term, only disable background scanning when the auto-connect list empty. Otherwise keep it active and let the controller deal with the two instances of state machines by itself.

Now we need to check if that would work or not. We have quirks like HCI_QUIRK_SIMULTANEOUS_DISCOVERY and this might need another one. Not sure if we want to go with blacklist or whitelist here. I would do blacklist and actually check the supported states. Since this is LE only, the controller should not lie to us.

If you want to work on this, then try this simple approach:

a) Read the supported states and extract support for passive scanning + initiating
a) Use a long timeout
b) Only disable scanning when no other device is left on auto-connect list

If this basically works, then the only other thing we have to do is be smart about concurrent connection. Meaning that a long running one can be cancelled and replaced with something we see in the 2-x second window. As I said above, the 0-2 second window should be exclusive to the first attempt. We can tune these values, it is just the 20 second one is killing low-latency reconnect by HID device.

However there is one case to be made that we might only consider direct advertising to be able to interrupt it. Which would satisfy the HID requirement with low-latency. The advantage here is that they are high duty cycle and would show up right away. So you are not really losing out on your slow-connection attempt.

But this idea really stands and falls with the passive scanning + initiating state support in the controller.

Regards

Marcel

