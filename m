Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_MXB71MTcbrViLh486RtpWpx+a7SDvUPdSj2VdOa1fWvw@mail.gmail.com>
References: <508D6672.8000009@globaledgesoft.com>
	<CAJdJm_MXB71MTcbrViLh486RtpWpx+a7SDvUPdSj2VdOa1fWvw@mail.gmail.com>
Date: Tue, 30 Oct 2012 07:50:44 -0400
Message-ID: <CAJdJm_NHaBzobi=k3cMaM-J_3d6R7FCEvfrSJWbkiKxKpjKHWA@mail.gmail.com>
Subject: Re: BLE issue: Start_LE_Encryption fails
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Ajay <ajay.kv@globaledgesoft.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

[Forgot to reply to the list]

On Tue, Oct 30, 2012 at 7:49 AM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Ajay,
>
> On Sun, Oct 28, 2012 at 1:08 PM, Ajay <ajay.kv@globaledgesoft.com> wrote:
>> Hi,
>>         I am getting le_long_term_key_negative reply  from the remote device
>> , on sending le_start_encryption . I am testing this with 2 ubuntu
>> machines(3.2.5) with IOGEAR dual mode dongles .
>
> To connect to a dual mode dongle, you need to set LE Adv. flags to
> 0x06 (which means general discoverable + BR/EDR not supported) on the
> acceptor side. You can use this command (on the acceptor/slave side):
>
> sudo hcitool -i hci0 cmd 0x08 0x0008 03 02 01 06 \
>     $(perl -e 'print "00 " x 28')
>
> Next, enable LE advertising:
>
> sudo hciconfig hci0 leadv
>
> On the initiator/master side, run "hcitool lescan" and try pairing again.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
