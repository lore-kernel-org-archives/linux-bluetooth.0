Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Jul 2012 14:54:04 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v13 10/14] audio: Move HFP HF server to telephony.c
Message-ID: <20120718115404.GB15775@x220.ger.corp.intel.com>
References: <1342532440-730-1-git-send-email-frederic.danis@linux.intel.com>
 <1342532440-730-11-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1342532440-730-11-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,
> +#if 0

No need to have dead code in the tree. If we need to bring something
back later we have the commit history for that.

Johan
