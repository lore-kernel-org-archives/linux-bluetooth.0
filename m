Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHZ1yC=FkUt=ESbZ+OnfSXKrN0+XHVgcMxqOjQq-EaJU+TPf-w@mail.gmail.com>
References: <CAHZ1yC=FkUt=ESbZ+OnfSXKrN0+XHVgcMxqOjQq-EaJU+TPf-w@mail.gmail.com>
Date: Thu, 28 Feb 2013 22:23:57 +0200
Message-ID: <CACumGOK+rmNt8xb6Ee-vkWRMoCDR0q-LQ-rPNsRwteKOpadJTQ@mail.gmail.com>
Subject: Re: Bluez 5.2 A2DP: "Unable to select SEP"
From: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
To: Scott James Remnant <keybuk@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

On Thu, Feb 28, 2013 at 9:51 PM, Scott James Remnant <keybuk@google.com> wrote:
> Hey,
>
> I'm having some difficulties connecting up A2DP in BlueZ 5.2, and I'm
> sure I'm just missing something obvious so would appreciate a second
> set of eyes.
>
> I had thought that to send to an A2DP Sink on a device, I needed an
> A2DP Source endpoint at my end, but when I try and register that
> endpoint I just get org.bluez.Error.NotSupported

Check your /etc/bluetooth/audio.conf, you must have disabled it for some reason.

> I can register an A2DP Sink endpoint no problem, but then when I call
> org.bluez.Device1.Connect the connection fails with "Unable to select
> SEP" in the logs.

You need to register a A2DP Source endpoint in case you want to send
to a Sink, maybe what happened is that we change the roles in the
audio.conf, it used to be the remote role/interface but I think commit
3a45f6e39fb89da3e518c43aa1bde5f41209c07d has changed that probably by
mistake since it doesn't mention anything in the description of the
patch.

Now the question is, shall we bring the old behavior back? In the long
term I think we will move away of plugin specific config file such as
audio.conf and have something in main.conf to disable the
plugins/profiles.
