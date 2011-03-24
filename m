Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 Mar 2011 17:29:22 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
Subject: Re: [PATCH v5 0/5] Support for OOB in mgmt interface
Message-ID: <20110324202922.GJ2236@joana>
References: <1300795943-6681-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300795943-6681-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

* Szymon Janc <szymon.janc@tieto.com> [2011-03-22 13:12:18 +0100]:

> Changes since v4:
> - include comments from Anderson Lizardo
> - use sizeof instead of hardcoded size in memcpy calls
> 
> BR,
> Szymon Janc
> on behalf of ST-Ericsson
> 
> Szymon Janc (5):
>   Bluetooth: Rename cmd to param in pending_cmd
>   Bluetooth: Allow for NULL data in mgmt_pending_add
>   Bluetooth: Add read_local_oob_data management command
>   Bluetooth: Add add/remove_remote_oob_data management commands
>   Bluetooth: Enable support for out of band association model


All 5 patches applied. Thanks for implement this.

-- 
Gustavo F. Padovan
http://profusion.mobi
