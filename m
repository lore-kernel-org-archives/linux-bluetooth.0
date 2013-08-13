Return-Path: <cyrus@holtmann.org>
Message-ID: <520A3040.2090209@linux.intel.com>
Date: Tue, 13 Aug 2013 15:10:24 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?=
 <frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] sco-tester: Update ECONNABORTED to EOPNOTSUPP
References: <1376062977-1497-1-git-send-email-frederic.dalleau@linux.intel.com> <09231CA6-E5F3-453E-9479-68F08072893A@holtmann.org> <52089E1F.60704@linux.intel.com> <88BDC584-6DC7-457A-92B3-3C00D30CCEBC@holtmann.org>
In-Reply-To: <88BDC584-6DC7-457A-92B3-3C00D30CCEBC@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Le 13/08/2013 01:22, Marcel Holtmann a écrit :

> However I only looked at the error codes you listed in this email. Maybe there is even a better one, maybe there is not. I am pretty much open to discuss alternatives here.

Thanks for detailed feedback. For the vast majority of other errors
code, there was no need to go through code to eliminate them: Their 
purpose if usually very restrictive.

Let's list some potential candidate just in case:
#define ENOSYS          38      /* Function not implemented */
#define ENOSR           63      /* Out of streams resources */
#define ENOMEDIUM       123     /* No medium found */

Regards,
Frederic
