Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v6 1/4] add one more buffer for stream reassembly
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: Suraj Sumangala <suraj@atheros.com>,
	linux-bluetooth@vger.kernel.org, Jothikumar.Mothilal@Atheros.com
In-Reply-To: <20100713210104.GA3106@vigoh>
References: <1279013611-4775-1-git-send-email-suraj@atheros.com>
	 <1279054151.6282.22.camel@localhost.localdomain>
	 <20100713210104.GA3106@vigoh>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Jul 2010 18:03:57 -0300
Message-ID: <1279055037.6282.24.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> > And don't forget to modify the __reassembly macro to do -1 instead of -2
> > now. Since we said we keep the [0] for the stream reassembly.
> 
> The __reassembly macro is removed in the following patches.

I know, but I prefer to keep these patches in a bisectable fashion to
have them make sense by itself.

Regards

Marcel



