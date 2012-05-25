Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 May 2012 11:37:45 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: andrei.emeltchenko.news@gmail.com
Cc: linux-kernel@vger.kernel.org, joe@perches.com,
	linux-bluetooth@vger.kernel.org,
	Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Subject: Re: [RFC] vsprintf: Add %pMR for Bluetooth MAC address
Message-ID: <20120525143745.GE31623@joana>
References: <1336778486.16292.0.camel@joe2Laptop>
 <1337956368-30621-1-git-send-email-andrei.emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337956368-30621-1-git-send-email-andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* andrei.emeltchenko.news@gmail.com <andrei.emeltchenko.news@gmail.com> [2012-05-25 17:32:48 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Bluetooth uses mostly LE byte order which is reversed for visual
> interpretation. Currently in Bluetooth in use unsafe batostr function.
> 
> This is slightly modified version of Joe Perches <joe@perches.com>
> patch (sent Sat, Dec 4, 2010).
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  lib/vsprintf.c |   22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)

Please resend this using the get-maintainers scripts in the --cc too (akpm et al)
so we can get this to the right people.


	Gustavo
