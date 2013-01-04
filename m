Return-Path: <cyrus@holtmann.org>
Message-ID: <50E6D865.7010805@linux.intel.com>
Date: Fri, 04 Jan 2013 14:25:57 +0100
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [REVIEW] adapter: Fix storage to be used by BlueZ 4 or 5
References: <1357305174-13313-1-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1357305174-13313-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 04/01/2013 14:12, Frédéric Danis wrote:
> Conversion should be performed only one time, but using "converted"
> entry in device related files generates a bogus device object with
> dev_CONVERTED path when starting BlueZ 4.
>
> If "settings" file has been created we've done the conversion and
> we can use it to check if conversion has already been done.
>
> Remove "converted" entries in converted files

Sorry, I made a mistake in mail subject, this patch is for integration.


-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation

