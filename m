Return-Path: <janice@asti.dost.gov.ph>
Subject: Re: [Bluez-users] bizzare result when getting the bluetooth address
From: jan d tux <janice@asti.dost.gov.ph>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1075722905.29899.10.camel@pegasus>
References: <1075714467.1546.49.camel@Asgard>
	 <1075722905.29899.10.camel@pegasus>
Content-Type: text/plain
Message-Id: <1075777047.1362.42.camel@Asgard>
Mime-Version: 1.0
Date: 03 Feb 2004 10:57:27 +0800
List-ID: <bluez-users.lists.sourceforge.net>

Thanks Marcel.

I have already inserted a len=sizeof(sa) before calling getpeername but
the result is still the same.

On Mon, 2004-02-02 at 19:55, Marcel Holtmann wrote:
> Hi Jan,
> 
> > Can anybody help me figure out why the bluetooth address I am getting is
> > not right?
> > 
> > What I am trying to do is get the bluetooth address of the sender/peer
> > to my obex server.
> > 
> > Here are the obex calls I made:
> > --------
> > 	handle = OBEX_Init(OBEX_TRANS_BLUETOOTH, obex_event, 0);
> > 
> > 	BtOBEX_ServerRegister(handle, NULL, OBEX_PUSH_HANDLE);
> > 
> > 	btobex_accept(handle);
> > 
> > 	OBEX_HandleInput(handle, 1);
> > 
> > 	//get addresss
> > 	
> > 	fd = OBEX_GetFD(handle);
> > 	if( fd < 0 )
> > 		return 0;
> > 
> > 	getpeername(fd,(struct sockaddr *)&sa,&len)
> > 		return 0;
> > 
> > 	baswap(&bdaddr, &sa.rc_bdaddr);
> > 	printf("\tADDRESS: %s\n", batostr(&bdaddr));
> > --------
> > 
> > 
> > when i run the program, i was able to get the following:
> >         channel: 10	
> >         family: 31
> >         ADDRESS 2: 00:0A:00:02:EE:69 -> this is not the bluetooth
> > address of the sender!!! Its address is 00:02:EE:69:E1:88. The last for
> > digits displayed are the 1st four digits of the device's real address. I
> > tried it with another device and the result is the same, from the
> > original address (00:E0:03:74:38:8E) to 00:0A:00:E0:03:74.
> 
> insert a "len = sizeof(sa)" before you call getpeername().
> 
> Regards
> 
> Marcel
> 
