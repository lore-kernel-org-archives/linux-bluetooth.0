Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bizzare result when getting the bluetooth address
From: jan d tux <janice@asti.dost.gov.ph>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1075807802.13285.0.camel@pegasus>
References: <1075714467.1546.49.camel@Asgard>
	 <1075722905.29899.10.camel@pegasus>  <1075777047.1362.42.camel@Asgard>
	 <1075807802.13285.0.camel@pegasus>
Content-Type: text/plain
Message-Id: <1075858415.994.59.camel@Asgard>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 04 Feb 2004 09:33:35 +0800

Hi to all :)

Here is the complete code of the server I am working on. The server code
is from http://www.frasunek.com/sources/unix/obexserver.c.



/* Simple OpenOBEX server for Bluez+OpenOBEX */
/* link with libmisc.a from OPENObex-apps and libopenobex from OpenOBEX
*/
/* venglin@freebsd.lublin.pl */


#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include <openobex/obex.h>
#include "obex_io.c"
#include "obex_put_common.c"
#include <bluetooth/rfcomm.h>

#define OBEX_PUSH_HANDLE	10

volatile int finished = 0;
obex_t *handle = NULL;

int Get_handle_bdaddr(obex_t *handle, char *str);
void obex_event(obex_t *handle, obex_object_t *object, int mode, int
event, int obex_cmd, int obex_rsp);

int main(int argc, char **argv)
{

	char str[256];
	int get;

	obex_object_t *object;

	handle = OBEX_Init(OBEX_TRANS_BLUETOOTH, obex_event, 0);

	if (argc == 1)
	{
		BtOBEX_ServerRegister(handle, NULL, OBEX_PUSH_HANDLE);
		printf("Waiting for connection...\n");
		btobex_accept(handle);

		while (!finished)
		{
			OBEX_HandleInput(handle, 1);
		}

		get=get_bdaddr(handle,str);
	}
}

/*
*	int get_bdaddr(obex_t *handle, char *str)
*   	I've added this function
*
*/
int get_bdaddr(obex_t *handle, char *str)
{
	int			fd;
	struct	sockaddr_rc	sa;
	socklen_t		len = sizeof(sa);


	if( (fd = OBEX_GetFD(handle)) < 0 )
		return 0;

	if( getpeername(fd,(struct sockaddr *)&sa,&len) < 0 )
		return 0;

	ba2str(&sa.rc_bdaddr,str);
	printf("\n\tADDRESS: %s\n", str);
	printf("\tchannel: %d\n", sa.rc_channel);
	printf("\tfamily: %d\n", sa.rc_family);

	return 1;
}


------------

I saved it inside the openobex-apps/src folder and compiled it using 
	gcc -o obexserver_temp obexserver_temp.c -lopenobex -lbluetooth



Thanks :)


On Tue, 2004-02-03 at 19:30, Marcel Holtmann wrote:
> Hi Jan,
> 
> > I have already inserted a len=sizeof(sa) before calling getpeername but
> > the result is still the same.
> 
> show us the complete code.
> 
> Regards
> 
> Marcel
> 




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
