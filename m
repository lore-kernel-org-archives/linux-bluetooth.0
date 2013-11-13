Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Nov 2013 11:27:24 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ravi Kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v2 1/3] android/hidhost: Handle uhid output and feature
 events
Message-ID: <20131113092724.GA1749@x220.p-661hnu-f1>
References: <1384268835-7570-1-git-send-email-ravikumar.veeramally@linux.intel.com>
 <20131113090159.GA32659@x220.p-661hnu-f1>
 <528343B1.5020306@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <528343B1.5020306@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Wed, Nov 13, 2013, Ravi Kumar Veeramally wrote:
> Hi Johan,
> 
> >>+		sscanf((char *) &(ev->u.output.data)[i * 2],
> >>+							"%hhx", &(req + 1)[i]);
> >The last parameter is a bit of a brain twister. How about simply &req[1 + i]?
> >
>   Yeap, simple :).

I fixed this up myself, so all three patches have now been applied.

Johan
