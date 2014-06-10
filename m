Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140609122130.5f43d7e2@han1-desk-dev>
References: <20140609083124.1ea9e852@han1-desk-dev>
	<8BACFBA7-C6B6-4BE7-9107-2E4665B3A278@holtmann.org>
	<20140609101542.5b7ae24a@han1-desk-dev>
	<98D1490C-B3DC-4CEC-971B-F24F515CFC2E@holtmann.org>
	<20140609122130.5f43d7e2@han1-desk-dev>
Date: Tue, 10 Jun 2014 11:27:10 +0300
Message-ID: <CABBYNZ+SYw8isMGSs=1i6CEt+c1nZ3R6PHy9VAgRfRSkYULfcQ@mail.gmail.com>
Subject: Re: Question about HCI_QUIRK_RESET_ON_CLOSE
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	"Gustavo F. Padovan" <gustavo@padovan.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd, Marcel,

On Mon, Jun 9, 2014 at 10:21 PM, Tedd Ho-Jeong An <tedd.an@intel.com> wrote=
:
> On Mon, 9 Jun 2014 19:50:24 +0200
> Marcel Holtmann <marcel@holtmann.org> wrote:
>
>> Hi Tedd,
>>
>> >>> I noticed that HCI_QUIRK_RESET_ON_CLOSE bit is used during stack ini=
tialization or device close exclusively.
>> >>> If the bit is set, HCI_RESET is sent to the device during device clo=
se but not during stack initialization and vice versa when it is not set. I=
 just wonder if there is any reason for doing it?
>> >>
>> >> Bluetooth 1.0b and some Bluetooth 1.1 devices have not a clear define=
d behavior on HCI_Reset when it comes to the host transport. Only Bluetooth=
 1.1 cleared that HCI_Reset is not suppose to reset the transport. For exam=
ple with USB. So you ended up seeing HCI_Reset, USB Reset, USB Disconnect, =
USB Connect endless cycles.
>> >>
>> >> A certain set of drivers are required to set this quirk. However even=
tually they have to do the HCI_Reset since otherwise we end up in funky sta=
tes. Check drivers/bluetooth/ for devices that require not to send the HCI_=
Reset on init.
>> >>
>> >>> What do you recommend if HCI_RESET needs to be sent for both stack i=
nitialization case and device close?
>> >>
>> >> I have been thinking about this a while ago. Instead of using HCI_Res=
et we actually started to modify the kernel to clear out all its states whe=
n we are powering down the controller. A recent bluetooth-next kernel shoul=
d just make sure we are no longer connectable and discoverable and also no =
longer advertising.
>> >>
>> >> We needed this for UART based devices where the transport has no clea=
r indication that it is down. With USB devices this problem normally never =
happens since we are bringing down USB as well.
>> >>
>> >> Do you need something else?
>> >
>> > We are seeing an issue while turning on/off BT with inquiry, especiall=
y extended inquiry. If BT is turned off right after sending an extended inq=
uiry, and next time when the BT is turned on the buffer is corrupted. We ha=
ve seen this on Chromebook with 3.10 kernel.
>>
>> that is actually a good question for Johan, are we also canceling any co=
nnection attempts, remote name requests and ongoing inquiry transaction. We=
 might need to verify that we really clean all of these that have baseband =
activity.
>>
>> > If the changes are made to recent version, I am not sure whether I can=
 push the changes to chromebook tree. If it is not acceptable, then I need =
to come up with something else like sending HCI_RESET upon closing the devi=
ce.
>>
>> So why are you getting a buffer corruption is kinda interesting. Since y=
ou will get a new HCI_Reset when you power Bluetooth back on. Not sure what=
 makes the difference if it comes at the beginning or at the end or both ti=
mes.
>>
>> Normally the HCI_Reset for UART based controllers is to ensure that all =
baseband resources are freed. That is what we are doing manually for each r=
esources. Calling HCI_Reset is just the cheap way out ;)
>
> Here is what we found. After the host sends extended inquiry and it is tu=
rned off, the device is still in inquiry state and updates the USB FIFO wit=
h inquiry results. Once the BT is turned on, then host sends the HCI_RESET =
but it returns with inquiry results in USB FIFO.
>
> If the host sends HCI_RESET before BT off, at least the device state will=
 be back to idle.

I thought this was the purpose of HCI_QUIRK_RESET_ON_CLOSE so that
drivers can really force the controller into inactivity by requesting
the stack to issue a reset before before BT off. This all seems rather
strange if the controller keeps the radio active on BT off there is
something broken and sending a reset won't fix that.

>>
>> The problem is that you can not know if sending HCI_Reset at the end is =
acceptable by all USB based devices. You need to quirk it. And right now it=
 is just one quirk. We do not have separate quirks for opening HCI_Reset an=
d closing HCI_Reset. That would need to be changed if we really need it. So=
 far we did not.
>>
> Is it possible to have something like HCI_QUIRK_RESET_ON_INIT? Existing i=
mplementation will still be there and if a HW vendor wants this feature, th=
ey can set this up for init.
>
>> But just a heads up, this also forces changes into hci_uart driver and i=
ts ioctl interface if we change this. So there is a bit of work to be done =
to do this cleanly and without breaking other controllers.
>>
>> > Do you know which patches should I start to look at?
>>
>> I think that 3.14 kernel and later have this feature enabled. What I can=
 tell is that we cancel connection attempts since I found a follow up patch=
 there. For inquiry and remote name request, I do not know.
>>
>> Johan, did we ever checked this and in addition that we send a Discovery=
 Stopped event as well.
>>
>> Regards
>>
>> Marcel
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Luiz Augusto von Dentz
