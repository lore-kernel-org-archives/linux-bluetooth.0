Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFCv2 3/7] Bluetooth: EFS: add disable_flowspec kernel param
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <padovan@profusion.mobi>
Cc: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Date: Wed, 14 Sep 2011 07:30:11 +0200
In-Reply-To: <20110913201724.GE16856@joana>
References: <1314875256-6904-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1314875256-6904-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <20110913201724.GE16856@joana>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1315978212.1937.35.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> >  
> >  int disable_ertm;
> > +int disable_flowspec = 1;
> 
> I'm not sure if we need one parameter for each feature, I think a
> disable_hs (for high speed) could work. This is only to keep the code upstream
> while it is not qualified.

and it should be named enable_hs similar to enable_le.

Regards

Marcel


