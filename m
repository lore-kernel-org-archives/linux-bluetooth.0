Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <462F8FCE.3090102@idlum.be>
References: <462F8FCE.3090102@idlum.be>
Date: Wed, 25 Apr 2007 21:07:46 +0200
Message-Id: <1177528066.14980.21.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Extremely slow SDP extraction from phone
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Pierre-Yves,

> I'm using BlueZ 3.9 and the DBus API from a custom application to 
> extract the SDP records from a phone. To achieve this, I first perform a 
> call to
> 
> array{uint32} GetRemoteServiceHandles(string address, string match)
> 
> with an empty "match" string. It does connect to Public Browse Group,
> and returns handles for all the ServiceRecords. I then perform a call
> 
> array{byte} GetRemoteServiceRecord(string address, uint32 handle)
> 
> for each of these handles, and I get all the data in binary form, and I 
>   deal with them myself in this form.
> 
> Problem is that I sometimes encounter very long delays to extract a 
> record using its handle.

we should implement a disconnect timeout for the SDP session. It makes
sense to keep the SDP session open for subsequent SDP request. However
this hasn't been implemented right now.

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
