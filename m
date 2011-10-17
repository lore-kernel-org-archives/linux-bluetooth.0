Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/9] Bluetooth: Add BT_AMP_POLICY socket option
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Mat Martineau <mathewm@codeaurora.org>,
	linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org, andrei.emeltchenko@intel.com
Date: Mon, 17 Oct 2011 08:56:54 -0700
In-Reply-To: <CABBYNZKtyro_ep=X1Baq51oUXueqMDVEr_0aZw54+c48SvtWcw@mail.gmail.com>
References: <1318543247-27130-1-git-send-email-mathewm@codeaurora.org>
	 <1318543247-27130-2-git-send-email-mathewm@codeaurora.org>
	 <1318549090.15441.49.camel@aeonflux>
	 <alpine.DEB.2.02.1110141410410.9993@mathewm-linux>
	 <CABBYNZKtyro_ep=X1Baq51oUXueqMDVEr_0aZw54+c48SvtWcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1318867017.15441.102.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> >> Not sure if applications actually do care, but for OBEX it might be
> >> interesting to know if you are on an AMP controller right now or not.
> >
> > Yes, that would be a nice feature.  OBEX seems to work well even without it,
> > though.  The OBEX connection is made over BREDR, and the socket option is
> > changed after the OBEX connection is made but before any gets or puts.  What
> > you see in hcidump is that the move starts before the first get or put goes
> > out over BREDR - those OBEX packets sit in the ERTM tx queue while the
> > channel move happens.  When the move completes, the transfer immediatly
> > proceeds on the AMP controller.
> 
> I guess the is implementation dependent, for obexd we might want to
> check if the transfer will take a considerable amount of time to
> decide whether or not to use AMP, in some case it might not worth to
> switch because it will take more time than transferring over BDEDR.

there has been discussions that you should be waiting for the first
packet on BR/EDR and hope that it indicates the length of the data to
follow. And then make a decision to allow switching or not. All three
options would support this behavior right now.

Until we are collecting real data for the switching time with BlueZ, we
will have no idea anyway and everything will be a guess.

Regards

Marcel


