Return-Path: <cyrus@holtmann.org>
Message-ID: <1355926076.1827.7.camel@aeonflux>
Subject: Re: [PATCH] monitor: Fix crash in btmon
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 19 Dec 2012 15:07:56 +0100
In-Reply-To: <1355923202-16648-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355923202-16648-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> When retrieving SDP records from keyboard btmon crashes (see below).
> 
> The tid_list in sdp.c is filled up by SDP Service search request,
> as Service Search responses are treated as invalid and do not free
> tid_list entries.
> 
> This is due to passing last fragment instead of complete frame to
> l2cap_frame().

please send me the binary log file privately. I like to have a look at
this in detail. What device have you tested this against?

Regards

Marcel


