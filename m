Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2d5a2c100906131323m158007ecgd7f4a738a5ed660@mail.gmail.com>
References: <434c4b6e0906130513r74959ee2u3bf8c2892a961c66@mail.gmail.com>
	 <2d5a2c100906131323m158007ecgd7f4a738a5ed660@mail.gmail.com>
Date: Sun, 14 Jun 2009 13:58:06 +0900
Message-ID: <434c4b6e0906132158o1cfc8190xe53dc9532582e33f@mail.gmail.com>
Subject: Re: Re-configuration Issue about A2DP
From: "Chanyeol,Park" <chanyeol.park@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Before sending that log(this is my home..-.-),
I provide an additional information
 because I want to check what I asked is exactly what you saw ^^.

In a2dp_source_config() , it checks avdtp_stream_has_capabilities().
Below cae, I saw avdtp_close():(1385 line) and set
setup-reconfiguration is TRUE;
and I saw bluez receive Close_cfm. and after that a2dp_reconfigure()
was called...

However... It doesn't work well...-.-;

Did you mean to add RECONFIGURE_TIMEOUT more than 500 ms...?


After doing that, I would send the more log..




2009/6/14 Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
> Hi,
>
> On Sat, Jun 13, 2009 at 9:13 AM, Chanyeol,Park<chanyeol.park@gmail.com> wrote:
>> Hello
>>
>> Have you experience A2DP connection lost or corruption, when a user
>> changes A2DP configuration between mono and stereo, or between 44.1khz
>> 48khz
>>
>> Though I check bluez receives Close Cfm from headset , and Bluez sends
>> set_configuration to stereo headset. However Bluez get an error”
>> "Stream End Point in Use( 19). -.-;
>
> Ive got the same problem with some headsets, basically they only
> unlock the end point after some time. Not sure if adding an interval
> for reconfiguring would help since that seems to depend on the
> headset, anyway please provide the output of hcidump and bluetoothd so
> we can investigate what could be done in this case.
>
>
> --
> Luiz Augusto von Dentz
> Engenheiro de Computação
>
