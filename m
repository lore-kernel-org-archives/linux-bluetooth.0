Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: Question about HCI_QUIRK_RESET_ON_CLOSE
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZ+SYw8isMGSs=1i6CEt+c1nZ3R6PHy9VAgRfRSkYULfcQ@mail.gmail.com>
Date: Tue, 10 Jun 2014 11:25:17 +0200
Cc: Tedd Ho-Jeong An <tedd.an@intel.com>,
	Linux Bluetooth mailing list
	<linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"Gustavo F. Padovan" <gustavo@padovan.org>
Message-Id: <08DDD269-D7D4-4A3F-A5A0-EECF0A30B188@holtmann.org>
References: <20140609083124.1ea9e852@han1-desk-dev> <8BACFBA7-C6B6-4BE7-9107-2E4665B3A278@holtmann.org> <20140609101542.5b7ae24a@han1-desk-dev> <98D1490C-B3DC-4CEC-971B-F24F515CFC2E@holtmann.org> <20140609122130.5f43d7e2@han1-desk-dev> <CABBYNZ+SYw8isMGSs=1i6CEt+c1nZ3R6PHy9VAgRfRSkYULfcQ@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>>>>>> I noticed that HCI_QUIRK_RESET_ON_CLOSE bit is used during stack initialization or device close exclusively.
>>>>>> If the bit is set, HCI_RESET is sent to the device during device close but not during stack initialization and vice versa when it is not set. I just wonder if there is any reason for doing it?
>>>>> 
>>>>> Bluetooth 1.0b and some Bluetooth 1.1 devices have not a clear defined behavior on HCI_Reset when it comes to the host transport. Only Bluetooth 1.1 cleared that HCI_Reset is not suppose to reset the transport. For example with USB. So you ended up seeing HCI_Reset, USB Reset, USB Disconnect, USB Connect endless cycles.
>>>>> 
>>>>> A certain set of drivers are required to set this quirk. However eventually they have to do the HCI_Reset since otherwise we end up in funky states. Check drivers/bluetooth/ for devices that require not to send the HCI_Reset on init.
>>>>> 
>>>>>> What do you recommend if HCI_RESET needs to be sent for both stack initialization case and device close?
>>>>> 
>>>>> I have been thinking about this a while ago. Instead of using HCI_Reset we actually started to modify the kernel to clear out all its states when we are powering down the controller. A recent bluetooth-next kernel should just make sure we are no longer connectable and discoverable and also no longer advertising.
>>>>> 
>>>>> We needed this for UART based devices where the transport has no clear indication that it is down. With USB devices this problem normally never happens since we are bringing down USB as well.
>>>>> 
>>>>> Do you need something else?
>>>> 
>>>> We are seeing an issue while turning on/off BT with inquiry, especially extended inquiry. If BT is turned off right after sending an extended inquiry, and next time when the BT is turned on the buffer is corrupted. We have seen this on Chromebook with 3.10 kernel.
>>> 
>>> that is actually a good question for Johan, are we also canceling any connection attempts, remote name requests and ongoing inquiry transaction. We might need to verify that we really clean all of these that have baseband activity.
>>> 
>>>> If the changes are made to recent version, I am not sure whether I can push the changes to chromebook tree. If it is not acceptable, then I need to come up with something else like sending HCI_RESET upon closing the device.
>>> 
>>> So why are you getting a buffer corruption is kinda interesting. Since you will get a new HCI_Reset when you power Bluetooth back on. Not sure what makes the difference if it comes at the beginning or at the end or both times.
>>> 
>>> Normally the HCI_Reset for UART based controllers is to ensure that all baseband resources are freed. That is what we are doing manually for each resources. Calling HCI_Reset is just the cheap way out ;)
>> 
>> Here is what we found. After the host sends extended inquiry and it is turned off, the device is still in inquiry state and updates the USB FIFO with inquiry results. Once the BT is turned on, then host sends the HCI_RESET but it returns with inquiry results in USB FIFO.
>> 
>> If the host sends HCI_RESET before BT off, at least the device state will be back to idle.
> 
> I thought this was the purpose of HCI_QUIRK_RESET_ON_CLOSE so that
> drivers can really force the controller into inactivity by requesting
> the stack to issue a reset before before BT off. This all seems rather
> strange if the controller keeps the radio active on BT off there is
> something broken and sending a reset won't fix that.
> 

the reset on close quirk only tell the Bluetooth core when to issue the HCI_Reset. Default is that we reset during init. However for Bluetooth 1.0b and some 1.1 devices we call the HCI_Reset at the end. That is all what the quirk is doing. It was never intended for a providing dedicated reset quirks for init and closing.

Back in the days it was just HCI_QUIRK_RESET, but luckily from Bluetooth 1.2 and forward this was default and we changed the quirk meaning to mark the bad sheep and not punish the good ones. Most modern controllers rely on the HCI_Reset in the beginning to set up basics for their baseband and radio pipeline. I have seen many controllers that will not work properly if you do not send HCI_Reset in the beginning.

So if you actually set HCI_QUIRK_RESET_ON_CLOSE, then it means that we are now no longer sending the HCI_Reset on init. Which means the controller does not work properly either.

The real fix here is that we cancel inquiry and remote name request operations that occupy the baseband and will cause HCI event along the line later on. We could also set the HCI event mask(s) to zero.

Regards

Marcel

