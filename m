Return-Path: <cyrus@holtmann.org>
Message-ID: <1350663025.2026.38.camel@aeonflux>
Subject: Re: [RFC v0 13/15] profile: Rename org.bluez.Profile->ProfileAgent
From: Marcel Holtmann <marcel@holtmann.org>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Date: Fri, 19 Oct 2012 09:10:25 -0700
In-Reply-To: <1350661172-18125-14-git-send-email-mikel.astiz.oss@gmail.com>
References: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
	 <1350661172-18125-14-git-send-email-mikel.astiz.oss@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

> The interface represents an external component supporting a specific
> profile by implementing an agent. Therefore ProfileAgent is a more
> accurate name for the D-Bus interface.

actually I think Johan and I discussed this. And the reason for keeping
the name Profile is that the external component implements the profile.
It is not just an agent, it is the profile.

Regards

Marcel


