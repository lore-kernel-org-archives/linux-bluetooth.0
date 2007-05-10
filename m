Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <464338E7.9080902@access-company.com>
Date: Thu, 10 May 2007 17:23:19 +0200
From: Frederic Dalleau <frederic.dalleau@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <4642D045.60007@access-company.com>	<1178789626.25565.71.camel@aeonflux.holtmann.net>	<4642E92C.6030604@access-company.com>
	<1178791415.25565.83.camel@aeonflux.holtmann.net>
In-Reply-To: <1178791415.25565.83.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] non persistent sdp records
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

Marcel Holtmann wrote:
> actually using the standalone is a race condition. You should really
> consider switching to hcid -s. It also saves you some memory footprint.
>   
Well, I'm lazy, I would like not to rewrite code...
>> We will probably consider dbus as is sounds much easier, but it is 
>> important to be able to do as much as what can be done through sdp api.
>>     
> Why?
>   
I wasn't clear, I meant having no regression in regards to what we 
actually use, doing exactly the same sdp records we have in pand, a2dpd, ...

Frederic


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
