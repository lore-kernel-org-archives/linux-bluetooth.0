Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20051212093435.66664.qmail@web50507.mail.yahoo.com>
From: oj ravadilla <ojravadilla@yahoo.com>
Subject: Re: [Bluez-users] problem adding 1284 ID SDP attribute
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20051212092649.65060.qmail@web32403.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 12 Dec 2005 01:34:35 -0800 (PST)

Hi Marcel,

I'm having problems like this too. I cant add a 1248
id because of 0x00 that I assume is interpreted by the
bluezstack as a null terminator. 

Thanks!

--- Arch Sayo <a12chi@yahoo.com> wrote:

> Hi Marcel,
>    
>   I am having a problem adding the 1284ID attribute.
> The 1284ID is of type String. (So I use
> SDP_TEXT_STR8) However, the first 2 characters of
> this string are to be interpreted as a 2-byte length
> field. The length of my string is 80 which is 0x0050
> in HEXADECIMAL. So when I add it as a string, the
> SDP function interprets the 1st byte as a null
> terminator and sends an empty string.
>    
>   I tried increasing the length of my string to
> 0x0101 to avoid a 0x00 byte. However, this cannot be
> done since the maximum length for an SDP_TEXT_STR8
> is only 255 which is 0x00FF.
>    
>   In this case, how will I be able to add a 1284ID
> string attribute whose length field contains a 0x00
> byte?
>    
>   Thanks,
>   Arch Sayo
> 
> 			
> ---------------------------------
> Yahoo! Shopping
>  Find Great Deals on Holiday Gifts at Yahoo!
> Shopping 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
