Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: Discoverable undirected advertising report event
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CACUGKYM2kybUEh3oruas3R7FNnQLLrED80CRDQ9fDwXQkW_duA@mail.gmail.com>
Date: Tue, 28 Oct 2014 10:32:43 -0700
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <BD42489A-6D73-4CBC-B8A8-9E9A2D844966@holtmann.org>
References: <CACUGKYM2kybUEh3oruas3R7FNnQLLrED80CRDQ9fDwXQkW_duA@mail.gmail.com>
To: John Tobias <john.tobias.ph@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

> Is there any existing command to respond to PTS for (discoverable
> undirected advertising report event  - TC_BROB_BCST_BV_02_C)?.

you just use btmgmt and set yourself to discoverable and advertising.

Regards

Marcel

