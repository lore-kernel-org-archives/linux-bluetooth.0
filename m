Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <474B34DC.3080005@frederic-blain.com>
Date: Mon, 26 Nov 2007 21:04:28 +0000
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Blain?= <bluez@frederic-blain.com>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>
References: <47477234.9010007@free.fr>	
	<1195956126.10878.444.camel@cookie.hadess.net>	
	<1196057724.4217.71.camel@aeonflux>	
	<1196098681.10878.486.camel@cookie.hadess.net>
	<1196103584.10878.490.camel@cookie.hadess.net>
In-Reply-To: <1196103584.10878.490.camel@cookie.hadess.net>
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Sony PS3 sixaxis & bluez
Reply-To: bluez@frederic-blain.com,
        BlueZ development <bluez-devel@lists.sourceforge.net>
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

Bastien Nocera wrote:
> Frederic, could you check it works for you?
>   
Everything's fine with sixpair2.

Just  need to adjust the trusts file.
This could be easily done by adding something like :

  bdaddr_t hostaddr;
  str2ba(option_master, &hostaddr);
  write_trust(&hostaddr, device, GLOBAL_TRUST, TRUE);

instead of "//FIXME finally, set device as trusted" in handle_device() 
(sixpair2.c:316)
However, write_trust() is defined in hcid/hcid.h and implemented in 
hcid/storage.c.
Since both hcid/storage.c and input/storage.c implement the function 
read_device_name(),
with a different prototype, it can not compile :

../hcid/hcid.h:193: error: conflicting types for 'read_device_name'
storage.h:36: error: previous declaration of 'read_device_name' was here

/tmp/ccE5MOV3.o: In function `read_device_name':
storage.c:(.opd+0x138): multiple definition of `read_device_name'


It could be good to move write_trust() and GLOBAL_TRUST (hcid/hcid.h) in 
the common directory / lib.

Whatever, thanks a lot for your work,

-- 
creber



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
