Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4ECE3B67.1030909@globaledgesoft.com>
References: <4ECE3B67.1030909@globaledgesoft.com>
Date: Thu, 24 Nov 2011 15:54:30 +0200
Message-ID: <CABBYNZJMPhnX8DkOQEL76tGvHkP3riskm2c1pfu4=CyCU39sHg@mail.gmail.com>
Subject: Re: AVRCP metadat
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: sathish <sathish.n@globaledgesoft.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Nov 24, 2011 at 2:41 PM, sathish <sathish.n@globaledgesoft.com> wrote:
>  Hi,
>    I am working on implementing AVRCP 1.3 using the latest bluez that i
> downloaded from repository bluez.kernel.org.git file and i am working to get
> the metadata information from the media player "amarok" .
>
> i already succeded in writing the code using dbus API on bluez-4.96. The
> features such as VolumeUp, VolumeDown, Pause , Stop, GetProperties(Status
> Connected Only) are working fine.
>
> I want help to implement in getting metadata information, I want to know
> which player to use that supports in sending the metadata information.
>
> and suggestions how to use dbus API requesting some more example code for
> writing dbus in C.

You can use test/mpris-player.c as a C reference and there is also
test/simple-player in python, it is quite possible that amarok
implements mpris interface so that you can use mpris-player to
extract/convert the metadata.

-- 
Luiz Augusto von Dentz
