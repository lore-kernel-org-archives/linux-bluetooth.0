Return-Path: <cyrus@holtmann.org>
Date: Mon, 28 Mar 2011 23:48:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/6] Move Attrib client (including: should we
 disconnect or not?)
Message-ID: <20110328204806.GA29708@jh-x301>
References: <1301097673-5262-1-git-send-email-vinicius.gomes@openbossa.org>
 <20110328203346.GA2664@piper>
 <AANLkTin8et-m0pczJKm9y3z-EHqQdN-49KkAXGGm8jqO@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTin8et-m0pczJKm9y3z-EHqQdN-49KkAXGGm8jqO@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio & Vinicius,

> >> The move itself is pretty simple, but when implementing it, I took a decision
> >> and I would like to hear your opinion about it.
> >
> > There were problems with some useless includes. I will send another version
> > soon. But the question below remains.
> >
> >>
> >> With this patch series, the behaviour is that we never disconnect from
> >> a LE device unless we are told so, i.e. org.bluez.Device.Disconnect(),
> >> is that what is expected from us?
> 
> In my opinion, the profiles should define how to manage connections.
> For LE re-connections should be avoided since the remote disables the
> advertising when the connection is established.
> Keep the link up seems to be acceptable for now, but for the final
> solution we need to disconnect based on the registered "watchers" and
> profile inputs. Some profiles such as proximity keeps the devices
> always connected and auto-reconnect, others require user interaction.

Sounds good enough to me, i.e. let's keep "connected until an explicit
disconnect request from the user" the default for now.

Johan
