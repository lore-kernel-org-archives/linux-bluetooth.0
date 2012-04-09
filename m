Return-Path: <cyrus@holtmann.org>
Message-ID: <1333955136.16897.26.camel@aeonflux>
Subject: Re: [PATCH] mgmtops: Handle Start Discovery Complete in case of
 failure
From: Marcel Holtmann <marcel@holtmann.org>
To: Hemant Gupta <hemant.gupta@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 09 Apr 2012 09:05:36 +0200
In-Reply-To: <1333950443-32114-1-git-send-email-hemant.gupta@stericsson.com>
References: <1333950443-32114-1-git-send-email-hemant.gupta@stericsson.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hemant,

> This patch adds handling of start discovery complete event in cases
> when discovery fails to get started.
> 
> Change-Id: I214c8deb10fd97a529faeec50d789478aea2f402

please do not include the Android specific change id stuff in the
upstream patches.

Regards

Marcel


