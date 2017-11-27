Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH BlueZ 4/4] shared/shell: Add default argument generator
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20171126202126.27783-1-luiz.dentz@gmail.com>
 <20171126202126.27783-4-luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <3e3cdcc8-a641-34d1-dfbd-980cddfc8bad@jp.fujitsu.com>
Date: Mon, 27 Nov 2017 13:17:10 +0900
MIME-Version: 1.0
In-Reply-To: <20171126202126.27783-4-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 11/27/2017 05:21 AM, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds a default argument generator if the command don't provide
> one, the generator will print out the argument list so the user don't
> have to always resort to help for checking it.

The generator complements the unusable string in the command input line.
So we have to delete it for inputting a right value/string if the argument
list is complemented.

I think that showing the usage/argument outside the command input line is
better than complementing the argument list.


Regards,
Eramoto

