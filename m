Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Re: Re: Re: Re: hciattach problem
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <42065FAA.8030309@web.de>
References: <42065FAA.8030309@web.de>
Content-Type: text/plain
Message-Id: <1107714956.12834.72.camel@pegasus>
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
Date: Sun, 06 Feb 2005 19:35:56 +0100

Hi Andreas,

> >no. The libs and utils will not change the behaviour of your kernel. I
> >think you had an experimental patch in one of the kernels that causes
> >your problem. May you wanna also check the 2.6.11-rc3 to be sure that
> >everything is fine.
> >
> >  
> I have checked with -mh3, too, and it does also work. I have no 
> experimental patch in my kernel, so I don't know, what the problem was. 
> But I think, I have done something wrong in the config or so. Thanks for 
> your help.

actually I asked you to test 2.6.11-rc3 and not the -mh3. I want to be
sure that the latest testing kernel before the final 2.6.11 has no
problems with it. So grab 2.6.11-rc3-bk3 and test it please.

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
