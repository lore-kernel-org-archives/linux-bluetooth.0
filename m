Return-Path: <cyrus@holtmann.org>
Message-ID: <508DDCE7.6030708@globaledgesoft.com>
Date: Mon, 29 Oct 2012 07:03:27 +0530
From: Ajay <ajay.kv@globaledgesoft.com>
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: BLE issue: Start_LE_Encryption fails
References: <508D6672.8000009@globaledgesoft.com> <CAJdJm_MXB71MTcbrViLh486RtpWpx+a7SDvUPdSj2VdOa1fWvw@mail.gmail.com> <CAJdJm_NHaBzobi=k3cMaM-J_3d6R7FCEvfrSJWbkiKxKpjKHWA@mail.gmail.com> <508DCE10.40801@globaledgesoft.com> <CAJdJm_P=USyDO5op7_7ynOT8Qe7dOifyN=notezK1HGCxOe8bA@mail.gmail.com>
In-Reply-To: <CAJdJm_P=USyDO5op7_7ynOT8Qe7dOifyN=notezK1HGCxOe8bA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tuesday 30 October 2012 06:42 PM, Anderson Lizardo wrote:
> Hi Ajay,
>
> On Sun, Oct 28, 2012 at 8:30 PM, Ajay <ajay.kv@globaledgesoft.com> wrote:
>> Thanks, but "sudo hcitool -i hci0 cmd 0x08 0x0008 03 02 01 06 " ,   this
>> command only sets the advertising data to zero right . so how do i set the
>> adv flag as 0x06 . Which hci command is used for this  purpose .
>
> No, this sets adv. data to have "Flags" AD set to 0x06. But you missed
> the second line of the command:
>
> sudo hcitool -i hci0 cmd 0x08 0x0008 03 02 01 06 \
>      $(perl -e 'print "00 " x 28')
>
> The second line is important because it fills the other bytes with
> zero (which some controllers require).
>
> Regards,
>
  ya , i got your point ,advertiser is informing the remote device  , 
that it is not BR/EDR capable .That is done and device is connecting now.
	But  still i dont know, how to do le specific pairing and 
start_encryption enable(part of le pairing) . Is there any tool in bluez 
  providing LE pairing before connecting the devices (want to try with 2 
ubuntu pc's ).

-- 
Thanks & regards

  AJAY KV
  GlobalEdge software Ltd
  8892753703
