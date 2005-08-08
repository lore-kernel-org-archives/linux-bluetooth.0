Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bccmd patch, find connection handle by bdaddr
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050808115620.EEB243BF@arbetsmyra.dyndns.org>
References: <20050808115620.EEB243BF@arbetsmyra.dyndns.org>
Content-Type: text/plain
Message-Id: <1123522342.7751.49.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 08 Aug 2005 19:32:22 +0200

Hi Ronny,

> I've got a whole bunch of little enhancement patches to the bccmd, 
> pskey and l2ping utils. Marcel, as you wished earlier I'm posting them 
> small and separate. The one attached makes bccmd able to find a ACL 
> connection handle itself, instead of require user to provide it on 
> commandline. I'm using it in a cmd_keylen() patch (which I post when 
> this one gets applied).

please follow our coding style. This little code snippet breaks it at so
many places and it includes a free(NULL) bug.

The handle is uint32_t and you should keep the endian conversion in
mind.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
