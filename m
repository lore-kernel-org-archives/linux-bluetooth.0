Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <434c4b6e0906130513r74959ee2u3bf8c2892a961c66@mail.gmail.com>
References: <434c4b6e0906130513r74959ee2u3bf8c2892a961c66@mail.gmail.com>
Date: Sat, 13 Jun 2009 17:23:15 -0300
Message-ID: <2d5a2c100906131323m158007ecgd7f4a738a5ed660@mail.gmail.com>
Subject: Re: Re-configuration Issue about A2DP
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Chanyeol,Park" <chanyeol.park@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sat, Jun 13, 2009 at 9:13 AM, Chanyeol,Park<chanyeol.park@gmail.com> wrote:
> Hello
>
> Have you experience A2DP connection lost or corruption, when a user
> changes A2DP configuration between mono and stereo, or between 44.1khz
> 48khz
>
> Though I check bluez receives Close Cfm from headset , and Bluez sends
> set_configuration to stereo headset. However Bluez get an error”
> "Stream End Point in Use( 19). -.-;

Ive got the same problem with some headsets, basically they only
unlock the end point after some time. Not sure if adding an interval
for reconfiguring would help since that seems to depend on the
headset, anyway please provide the output of hcidump and bluetoothd so
we can investigate what could be done in this case.


-- 
Luiz Augusto von Dentz
Engenheiro de Computação
