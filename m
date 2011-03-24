Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <Waldemar.Rymarkiewicz@tieto.com>,
	<linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>
Date: Thu, 24 Mar 2011 17:08:54 +0200
Subject: RE: [PATCH] Add sap_disconnect_ind interface for sap-sim drivers.
Message-ID: <99B09243E1A5DA4898CDD8B7001114481085D15869@EXMB04.eu.tieto.com>
References: <1300982971-2869-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
In-Reply-To: <1300982971-2869-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>The sap_disconnect_ind() let's the sim driver to indicate 
>immediate disconnection.
>
>Add support of immediate disconnection in sap-dummy driver as 
>well as a card status change in order to pass all PTS tests.
>---
> sap/sap-dummy.c |   31 ++++++++++++++++++++++++-------
> sap/sap.h       |    1 +
> sap/server.c    |    8 ++++++++
> 3 files changed, 33 insertions(+), 7 deletions(-)

This patch let the SAP + dummy driver pass all PTS tests.

Waldek
