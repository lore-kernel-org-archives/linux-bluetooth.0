Return-Path: <cyrus@holtmann.org>
Subject: RE: [PATCH 2/3] Replace hci_recv_fragment calls
From: Marcel Holtmann <marcel@holtmann.org>
To: Luis Rodriguez <Luis.Rodriguez@Atheros.com>
Cc: Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
In-Reply-To: <BD672EAEE3AD2C47A7120B0973C3FB3A2DC28BB600@SC1EXMB-MBCL.global.atheros.com>
References: <1275379440.19477.9.camel@atheros013-desktop>
	 ,<1275379734.19477.14.camel@atheros013-desktop>
	 <BD672EAEE3AD2C47A7120B0973C3FB3A2DC28BB600@SC1EXMB-MBCL.global.atheros.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 01 Jun 2010 12:59:13 -0700
Message-ID: <1275422353.2182.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luis,

> You want to unify patches 1 and 2. Patches upstream should be atomic so that if  you apply it, it should make everything still work. Your first patch removes hci_recv_fragment() and then this one fixes the places that call it, you want to do both in one shot.

actually I prefer to leave these two patches out for now. Since the
renaming could be done easily later. The important part is actually the
other implementation.

Regards

Marcel


