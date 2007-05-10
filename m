Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4642E92C.6030604@access-company.com>
Date: Thu, 10 May 2007 11:43:08 +0200
From: Frederic Dalleau <frederic.dalleau@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <4642D045.60007@access-company.com>
	<1178789626.25565.71.camel@aeonflux.holtmann.net>
In-Reply-To: <1178789626.25565.71.camel@aeonflux.holtmann.net>
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

Marcel,
Thanks for answer. I'm using standalone sdpd.
We will probably consider dbus as is sounds much easier, but it is 
important to be able to do as much as what can be done through sdp api.
Frederic

Marcel Holtmann wrote:
> Hi Frederic,
>
>   
>> Until today, I was using non persistent sdp records like this
>>
>> sdp_connect()
>> sdp_record_alloc()
>> sdp_record_register()
>> sdp_record_free()
>> [Bluetooth profile executing]
>> sdp_close()
>>
>> Recently, I found my sdp records were accumulating each time I 
>> reregistered them, even if the sdp session was closed.
>> I saw this on bluez 3.9 but not on bluez 3.7.
>>
>> Does this mean all sdp records are now persistent or was I doing bad 
>> thing since the beginning or something else?
>>     
>
> this sounds like a bug. Do you use standalone sdpd or hcid with -s?
>
> You might wanna consider to use D-Bus to register the records since
> bluez-utils-3.10 is ready to be pushed out now.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>   


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
