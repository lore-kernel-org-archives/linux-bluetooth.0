Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH v2 3/3] android: Android version of log.c
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380024798-32017-3-git-send-email-frederic.danis@linux.intel.com>
Date: Fri, 27 Sep 2013 04:01:58 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7A4917A5-AD76-48AD-8C04-11707D64CE37@holtmann.org>
References: <1380024798-32017-1-git-send-email-frederic.danis@linux.intel.com> <1380024798-32017-3-git-send-email-frederic.danis@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Add logging system to BlueZ Android daemon.
> Android build will use android/log.c file while autotools build will use
> src/log.c instead.

lets just use stdout for now. Changing this later is pretty trivial and introducing large build alternates is a bit too complicated at this point.

Regards

Marcel

