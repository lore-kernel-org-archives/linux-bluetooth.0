Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] btaddr <-> name bug ?
From: Marcel Holtmann <marcel@holtmann.org>
To: Sjoerd Simons <sjoerd@spring.luon.net>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040630190206.GB26352@spring.luon.net>
References: <20040630190206.GB26352@spring.luon.net>
Content-Type: text/plain
Message-Id: <1088630304.4540.188.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 30 Jun 2004 23:18:24 +0200

Hi Sjoerd,

>   Doing hcitool scan a few times gives some weird output:
> 
> $ hcitool scan
> Scanning ...
>         00:0D:93:08:60:89       familiar (0)
>         00:02:C7:0B:97:F9       spring-0
> $ hcitool scan
> Scanning ...
>         00:0D:93:08:60:89       spring-0
>         00:02:C7:0B:97:F9       familiar (0)
> $ hcitool scan
> Scanning ...
>         00:0D:93:08:60:89       spring-0
>         00:02:C7:0B:97:F9       familiar (0)
> $ hcitool scan
> Scanning ...
>         00:0D:93:08:60:89       familiar (0)
>         00:02:C7:0B:97:F9       spring-0
> 
> The second and third run provide the right information, the first and last are 
> wrong.

provide us with the output of "hcidump -x" while you are running
"hcitool scan".

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
