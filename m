Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Jun 2011 11:17:29 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel =?iso-8859-1?Q?=D6rstadius?= <daniel.orstadius@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Init telephony before adding HFP SDP records
Message-ID: <20110601081729.GA9060@dell.ger.corp.intel.com>
References: <BANLkTi=L1xG3gVi9bmuW_YSWcOmu1HiRoQ@mail.gmail.com>
 <BANLkTin3vWrRigXOHQbJKr3rbN1xoirdYw@mail.gmail.com>
 <BANLkTi=1Si-h9AuMRCBKnBjhj6=LXYhuFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <BANLkTi=1Si-h9AuMRCBKnBjhj6=LXYhuFQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Fri, May 27, 2011, Daniel Örstadius wrote:
> Thanks for the feedback, that seems like a much leaner solution.
> Attaching new patch.
> 
> Regards,
> Daniel

> From 6ef2596d1b42abd6db51d22a5cf2239a0669ca12 Mon Sep 17 00:00:00 2001
> From: Daniel Orstadius <daniel.orstadius@nokia.com>
> Date: Fri, 27 May 2011 11:26:18 +0300
> Subject: [PATCH] Init telephony before adding the HFP SDP record
> 
> By patch b9d85c00108977b24ae91ea8ecedb9ceffe6f648 the initialization
> of the telephony subsystem is delayed in the bluetoothd startup
> procedure. As a result the SupportedFeatures bitmap has not been set
> when creating the HFP SDP record. This patch changes the order of
> the telephony initialization (via the state_changed function) and
> the registration of the record, so that it gets the right value.
> 
> Although the corresponding bit in +BRSF is correctly set, the
> missing bit for the "Three-way calling" feature in the SDP record
> causes some headsets not to send AT+CHLD=? in certain situations.
> This results in failed connections since BlueZ does not enter the
> "connected" state on the headset interface before that command is
> received, if the feature is supported by both sides.
> ---
>  audio/manager.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

Applied. Thanks.

Johan
