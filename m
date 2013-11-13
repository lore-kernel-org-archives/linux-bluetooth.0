Return-Path: <cyrus@holtmann.org>
Message-ID: <528343B1.5020306@linux.intel.com>
Date: Wed, 13 Nov 2013 11:17:37 +0200
From: Ravi Kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH_v2 1/3] android/hidhost: Handle uhid output and feature
 events
References: <1384268835-7570-1-git-send-email-ravikumar.veeramally@linux.intel.com> <20131113090159.GA32659@x220.p-661hnu-f1>
In-Reply-To: <20131113090159.GA32659@x220.p-661hnu-f1>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>> +		sscanf((char *) &(ev->u.output.data)[i * 2],
>> +							"%hhx", &(req + 1)[i]);
> The last parameter is a bit of a brain twister. How about simply &req[1 + i]?
>
   Yeap, simple :).

   Thanks,
   Ravi.
