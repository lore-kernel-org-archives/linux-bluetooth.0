Return-Path: <pkg-bluetooth-maintainers-bounces@lists.alioth.debian.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060604151505.GA16780@esaurito.net>
References: <20060519204815.GA8424@esaurito.net>
	<1148908581.31689.35.camel@localhost>
	<20060604151505.GA16780@esaurito.net>
Content-Type: text/plain
Date: Sun, 04 Jun 2006 17:46:54 +0200
Message-Id: <1149436014.8053.6.camel@localhost>
Mime-Version: 1.0
Subject: Bug#322732: [Bluez-devel] [Pkg-bluetooth-maintainers] Bug#322732:
	more on this bug (was: rfcomm bind fails with obscure error message)
Cc: 322732-submitter@bugs.debian.org, 322732@bugs.debian.org
Reply-To: Marcel Holtmann <marcel@holtmann.org>, 322732@bugs.debian.org
List-Unsubscribe: <http://lists.alioth.debian.org/mailman/listinfo/pkg-bluetooth-maintainers>,
	<mailto:pkg-bluetooth-maintainers-request@lists.alioth.debian.org?subject=unsubscribe>
List-Archive: <http://lists.alioth.debian.org/pipermail/pkg-bluetooth-maintainers>
List-Post: <mailto:pkg-bluetooth-maintainers@lists.alioth.debian.org>
List-Help: <mailto:pkg-bluetooth-maintainers-request@lists.alioth.debian.org?subject=help>
List-Subscribe: <http://lists.alioth.debian.org/mailman/listinfo/pkg-bluetooth-maintainers>,
	<mailto:pkg-bluetooth-maintainers-request@lists.alioth.debian.org?subject=subscribe>
Sender: pkg-bluetooth-maintainers-bounces@lists.alioth.debian.org
Errors-To: pkg-bluetooth-maintainers-bounces@lists.alioth.debian.org
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Filippo,

> > > comments? 
> > 
> > check for EOPNOTSUPP error code and only then print this error.
> 
> allright, I fixed this with the attached patch

the patch has been applied to the CVS now. Thanks.

Regards

Marcel




_______________________________________________
Pkg-bluetooth-maintainers mailing list
Pkg-bluetooth-maintainers@lists.alioth.debian.org
http://lists.alioth.debian.org/mailman/listinfo/pkg-bluetooth-maintainers
