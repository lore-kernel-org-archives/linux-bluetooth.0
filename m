Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <200911051142.31929.denkenz@gmail.com>
References: <200911051142.31929.denkenz@gmail.com>
Date: Thu, 5 Nov 2009 15:53:57 -0300
Message-ID: <2d5a2c100911051053m636c5532n5f105c30d721cfb6@mail.gmail.com>
Subject: Re: RFC: New Handsfree Client Role API
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Denis,

On Thu, Nov 5, 2009 at 2:42 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Everyone,
>
> As you know we're currently working to add support for Handsfree Profile (HFP)
> as another possible backend for oFono.  The missing piece is audio integration
> which is done in BlueZ.
>
> Proposed is an API for such integration between BlueZ and an AT engine that
> will implement the Handsfree Profile Client role.  The API will replace the
> current org.bluez.HeadsetGateway interface, if accepted.

I wonder if we couldn't create something more generic for telephony as
SAP could use the same agent, although SAP doesn't use AT commands
there are some overlap between handsfree Profile and Sim Access. Also
I prefer just RegisterAgent and UnregisterAgent, the interface already
has Handsfree in its name.

> An interesting thing to note here is that the API will utilize DBus 1.3+
> capability for file-descriptor passing to pass the RFCOMM socket from
> bluetoothd to oFono.

Pretty good, fd seems to fit very nicely here.

> This API has passed first round of review, but further comments, suggestions
> and refinements are welcome.

In general I prefer this Agent based (runtime) mechanism rather than
having those telephony drivers in BlueZ (buildtime), even for server
role, it is much easier to test (no rebuild and restart) and also very
convenient if e.g. the platform needs to talk to something (telepathy)
in session bus, in that case the agent process just need to connect to
both system and session bus but the driver can't do that since we
don't know about session.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
