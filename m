Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4FE05A21.9060406@linux.intel.com>
References: <8C91AD8ED4077A4786B341540858992510269B2E@SHSMSX102.ccr.corp.intel.com>
	<4FE05A21.9060406@linux.intel.com>
Date: Tue, 19 Jun 2012 13:57:18 +0300
Message-ID: <CABBYNZJqvZqBJ_R74UoBoRhXsUSzH0vOmExXSrM2mb0YAEpJFQ@mail.gmail.com>
Subject: Re: BT DUN Server fails to work (seems blocked in RFCOMM)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Cc: "Zhang, Jingke" <jingke.zhang@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

On Tue, Jun 19, 2012 at 1:53 PM, Frederic Danis
<frederic.danis@linux.intel.com> wrote:
> Your hcidump shows 2 SDP records for DUN profile.
>
> Guillaume Zajac and I found the same problem yesterday, and reply about it
> on oFono mailing list (see "Re: oFono DUN server issue" mails).
>
> It seems that BlueZ was compiled with embedded DUN server (configure option
> --enable-pnat).
> When both BlueZ and oFono are started, they both listen for incoming
> connection on RFCOMM port 1 (try "sdptool browse local" to check), and
> embedded BlueZ DUN server reply preventing oFono to manage this connection.
>
> If you remove the embedded DUN server by removing --enable-pnat from build
> configuration, it should work.

We should probably try to prevent this duplicate records to even
happen, specially if they use the same channel.

-- 
Luiz Augusto von Dentz
