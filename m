Return-Path: <cyrus@holtmann.org>
Message-ID: <508DCE10.40801@globaledgesoft.com>
Date: Mon, 29 Oct 2012 06:00:08 +0530
From: Ajay <ajay.kv@globaledgesoft.com>
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: BLE issue: Start_LE_Encryption fails
References: <508D6672.8000009@globaledgesoft.com> <CAJdJm_MXB71MTcbrViLh486RtpWpx+a7SDvUPdSj2VdOa1fWvw@mail.gmail.com> <CAJdJm_NHaBzobi=k3cMaM-J_3d6R7FCEvfrSJWbkiKxKpjKHWA@mail.gmail.com>
In-Reply-To: <CAJdJm_NHaBzobi=k3cMaM-J_3d6R7FCEvfrSJWbkiKxKpjKHWA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tuesday 30 October 2012 05:20 PM, Anderson Lizardo wrote:
> [Forgot to reply to the list]
>
> On Tue, Oct 30, 2012 at 7:49 AM, Anderson Lizardo
> <anderson.lizardo@openbossa.org> wrote:
>> Hi Ajay,
>>
>> On Sun, Oct 28, 2012 at 1:08 PM, Ajay <ajay.kv@globaledgesoft.com> wrote:
>>> Hi,
>>>          I am getting le_long_term_key_negative reply  from the remote device
>>> , on sending le_start_encryption . I am testing this with 2 ubuntu
>>> machines(3.2.5) with IOGEAR dual mode dongles .
>>
>> To connect to a dual mode dongle, you need to set LE Adv. flags to
>> 0x06 (which means general discoverable + BR/EDR not supported) on the
>> acceptor side. You can use this command (on the acceptor/slave side):
>>
>> sudo hcitool -i hci0 cmd 0x08 0x0008 03 02 01 06 \
>>      $(perl -e 'print "00 " x 28')
>>
>> Next, enable LE advertising:
>>
>> sudo hciconfig hci0 leadv
>>
>> On the initiator/master side, run "hcitool lescan" and try pairing again.
>
> Regards,
>

Thanks, but "sudo hcitool -i hci0 cmd 0x08 0x0008 03 02 01 06 " ,   this 
command only sets the advertising data to zero right . so how do i set 
the adv flag as 0x06 . Which hci command is used for this  purpose .
  	


-- 
Thanks & regards

  AJAY KV
  GlobalEdge software Ltd
  8892753703
