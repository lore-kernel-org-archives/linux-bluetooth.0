Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4649CC21.2070701@idlum.be>
References: <4649CC21.2070701@idlum.be>
Date: Tue, 15 May 2007 17:33:42 +0200
Message-Id: <1179243222.10069.26.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Error.InProgress forever after DBus timeout
	on	GetRemoteServiceHandles
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Pierre-Yves,

> I perform a call on GetRemoteServiceHandles. For some reason it fails 
> with a DBus timeout. After it has happened, each subsequent call to 
> GetRemoteServiceHandles about this device result in a Error.InProgress.
> 
> More precisely, my code tried it 36 times over about 7 minutes, and it 
> failed that way each time.
> 
> What should I do in such a case? It should somehow effectively timeout, 
> or there should be a way to cancel it. I didn't find any in the 
> dbus-api.txt file.

from the hcid side it is impossible to know when the request fails due
to a timeout. However calling the FinishRemoteServiceTransaction method
should cleanup the state and make it usable again. If not, then that is
a bug.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
