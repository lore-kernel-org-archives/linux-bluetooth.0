Return-Path: <cyrus@holtmann.org>
Message-ID: <1337190700.5970.266.camel@aeonflux>
Subject: Re: [PATCH 2/4] monitor: add device filter support
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 16 May 2012 10:51:40 -0700
In-Reply-To: <1337133263.5970.256.camel@aeonflux>
References: <1336753132-8282-1-git-send-email-gustavo@padovan.org>
	 <1336753132-8282-2-git-send-email-gustavo@padovan.org>
	 <1336964326.5970.238.camel@aeonflux> <20120515231404.GB1414@joana>
	 <1337133263.5970.256.camel@aeonflux>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> > > We better have some generic filtering mechanism, then trying to just
> > > duplicate options from hcidump into btmon.
> > > 
> > > btmon is different in the fact that it is actually able to record all
> > > packets from all devices. You also do not wanna filter based on index
> > > number. You wanna filter based on BD_ADDR and BR/EDR vs AMP.
> > 
> > Filter based on BD_ADDR would work too, but is more painful to the user
> > however.
> 
> I actually think having some sort of -f <filter> file where you can
> store BD_ADDR and potentially other filter options makes way more sense.

coming to think about this, the -f <filter> is the only proper way to
deal with this anyway. Everything else is just a hack. So I am currently
thinking in just doing a simple SSH config style filter file here.

	Controller aa:bb:cc:*
		Ignore

	Controller amp
		Ignore

	Controller bb:cc:*
		Hide sco,l2cap
		Show rfcomm
		Timestamps on

	Controller 11:22:33:44:55:66
		File x.btsnoop

Or something really similar to this. That way you can just have multiple
of these and only need to specify the correct file for what you are
trying to test. Including the capabilities to store BTSnoop files with
the same one command.

Regards

Marcel


