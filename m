Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Re: Re: Re: hciattach problem
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <42051547.5030301@web.de>
References: <42051547.5030301@web.de>
Content-Type: text/plain
Message-Id: <1107631098.6921.187.camel@pegasus>
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
Date: Sat, 05 Feb 2005 20:18:18 +0100

Hi Andreas,

> > please check 2.6.10-mh1 against 2.6.10-mh2, because otherwise we can't
> > find the problem. All your other kernels differ too much. The "csr"
> > option indicates H:4.
> 
> I have compiled a kernel 2.6.10-mh1 and a -mh2. I have tested it, and
> now there's no problem. I don't know why, but now there is no freez. 
> Maybe I have done something wrong with the compiling. Or do I have to 
> compile the bluez-utils/libs now with each kernel?

no. The libs and utils will not change the behaviour of your kernel. I
think you had an experimental patch in one of the kernels that causes
your problem. May you wanna also check the 2.6.11-rc3 to be sure that
everything is fine.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
