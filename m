Return-Path: <connman-bounces@lists.01.org>
Message-ID: <1449690002.8498.5.camel@linux.intel.com>
Subject: Re: [PATCH] gdbus: Move typedefs for interwork with strict compilers
From: Patrik Flykt <Patrik.Flykt@linux.intel.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Date: Wed, 09 Dec 2015 21:40:02 +0200
In-Reply-To: <20151209102412.GA16103@t440s.lan>
References: <1449590942-19235-1-git-send-email-patrik.flykt@linux.intel.com>
 <20151209102412.GA16103@t440s.lan>
Mime-Version: 1.0
Cc: connman@lists.01.org, linux-bluetooth@vger.kernel.org,
 Grant Erickson <marathon96@gmail.com>
List-Unsubscribe: <https://lists.01.org/mailman/options/connman>,
 <mailto:connman-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/connman/>
List-Post: <mailto:connman@lists.01.org>
List-Help: <mailto:connman-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/connman>,
 <mailto:connman-request@lists.01.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: connman-bounces@lists.01.org
Sender: "connman" <connman-bounces@lists.01.org>
List-ID: <linux-bluetooth.vger.kernel.org>


	Hi,

On Wed, 2015-12-09 at 12:24 +0200, Johan Hedberg wrote:
> Hi Patrik,
> 
> On Tue, Dec 08, 2015, Patrik Flykt wrote:
> > Move enumeration type defintions AFTER the enumerations themselves are declared
> > and defined such that the header works with strict compilers.
> > 
> > This occurs when building a plugin, compiled with C++, and occurs on all of:
> > 
> > arm-none-linux-gnueabi-g++ (Sourcery G++ Lite 2010q1-202) 4.4.1
> > arm-poky-linux-gnueabi-g++ (GCC) 4.8.2
> > g++ (Ubuntu 4.8.4-2ubuntu1~14.04) 4.8.4
> > ---
> > 
> > 	Hi,
> > 
> > This patch came up on the ConnMan mailing list, applies to Bluez too.
> > 
> > The patch is rebased to latest upstream and commit message amended with
> > more information.
> 
> Applied. Thanks.
> 
> Johan

Thanks. ConnMan ./gdbus is now in sync with Bluez.

Cheers,

	Patrik

_______________________________________________
connman mailing list
connman@lists.01.org
https://lists.01.org/mailman/listinfo/connman
