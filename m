Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42005A510007CC0F@resmta05.ono.com> (added by postmaster@resmta05.ono.com)
From: "radeX" <radex@ono.com>
To: <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1108039290.15974.33.camel@pegasus>
Subject: [Bluez-devel] HCI Forwarding
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
Date: Thu, 10 Feb 2005 14:10:25 +0100

Hi Marcel:

As you remember I was developing a gateway for tunneling the hci traffic
over TCP and be able to transfer files and play bluetooth games at long
distances.
I wrote a simple and very rudimentary C++ test program but didn't work. =
I
think the problem is the destination bluetooth address, would I need to
parse
the hci frames to set the bt address to its correct value?, I don't know
how to do this, I am really lost.
I tested the program with another friend running the same program with =
two
nokia n-gage.

If you can help me here is the source code, please feel free to modify
whatever
you want and tell me how can I solve this problem or give me a new way =
of
doing this.
(I marked up the important part of the main loop so you can see the main
idea witouth reading the full source), at the end is the program and =
hcidump
output.

If you want the full source (all files and makefile) tell me.

Thanks in advance.

-------------------------------------------------------------------------=
---
-
----main.cpp-----
#include <iostream.h>
#include <stdlib.h>

#include <sys/types.h>
#include <asm/types.h>
#include <netinet/in.h>
#include <arpa/inet.h>


#include "btsniffer.h"
#include "Socket.h"

using namespace std;

  bt_sniffer bt;
  Socket sk;
  int op;
  fd_set master;
  fd_set read_fds;
  int fdmax;
  int newfd;
  struct timeval tv;

int menu()
{
  int op;
  system("clear");
  cout << "Net-Gage testing program\n";
  cout << "-------------------------\n";
  cout << "[1] -- Connect to host\n";
  cout << "[2] -- Wait for connections\n";
  cout << "[0] -- Quit\n";
  cout << " Select option: ";
  cin >> op;
  return op;
}
void loop() {
  string buf;
  int rres =3D 0;
  int i;
  tv.tv_sec =3D 2;
  tv.tv_usec =3D 500000;
  sk.set_non_blocking(true);

  FD_SET(sk.m_sock, &master);
  FD_SET(bt.sock, &master);
  fdmax =3D bt.sock;

  cout << "Connection complete!.\n";
  cout << "---------------------\n";
  cout << "Running .....\n";
  cout << "<Press Ctrl-C to abort the program>\n";

  for(;;) {
    read_fds =3D master;
    if(select(fdmax+1, &read_fds, NULL, &read_fds, &tv) =3D=3D -1) {
      perror("select()!\n");
      exit(1);
    }
/********************/
/** IMPORTANT PART **/
/********************/
   if((rres =3D bt.receive()) > 0) {
         // BT Data received
         cout << "BT Data received: " << bt.buf << endl;
         sk.sendall(string(bt.buf));
    }

    if((rres =3D sk.recv(buf)) =3D=3D 0) {
       // Connection closed
       break;
    } else {
      if(rres > 0) {
         // TCP Data received
         cout << "TCP Data received: " << buf << endl;
         bt.send(buf.c_str());
      }
    }
/***************************/
/** END OF IMPORTANT PART **/
/***************************/
  }
  FD_CLR( sk.m_sock,&master);
  FD_CLR( bt.sock,&master);

  cout << "Connection closed.\n";
}

void do_connect()
{
  string ip;


  cout << "Enter IP address of the opponent: ";
  cin >> ip;
  cout << "Connecting to " << ip << " at port 1984 ...\n";
  sk.create();
  if(!sk.connect(ip, 1984)) {
    cout << "Connection failed !\n";
    exit(1);
  }
}
void do_listen()
{
  sk.create();
  if(!sk.bind(1984)) {
    cout << "Socket error: bind()! \n";
    exit(1);
  }

  cout << "Waiting for connections at port 1984 ...\n";
  sk.listen();
   while(!sk.accept(sk));
}

int main(void)
{

  FD_ZERO(&master);
  FD_ZERO(&read_fds);
  cout << "Starting netgage ...\n";

  bt.create();
  sk.set_non_blocking(true);
  bt.set_non_blocking(true);
  op =3D menu();
  switch(op) {
    case 1:
    do_connect();
    break;
    case 2:
    do_listen();
    break;
   }

  if(op) loop();
  cout << "Thank you for testing this program!\n";
  return EXIT_SUCCESS;
}
-------------------------------------------------------------------
-----btsniffer.cpp--------
#include "btsniffer.h"
 #include "btsniffer_exception.h"
 #include <errno.h>
 #include <fcntl.h>
 #include <sys/ioctl.h>

 bt_sniffer::bt_sniffer()
 {
    one =3D 1;

 }

 int bt_sniffer::receive()
 {
    return recv(sock, buf, HCI_MAX_FRAME_SIZE, 0);
 }
 void bt_sniffer::send(const char * s)
 {
    ::send(sock, s, HCI_MAX_FRAME_SIZE, 0);
 }

 void bt_sniffer::set_non_blocking ( const bool b )
 {

  int opts;

  opts =3D fcntl ( sock,
     F_GETFL );

  if ( opts < 0 )
    {
      return;
    }

  if ( b )
    opts =3D ( opts | O_NONBLOCK );
  else
    opts =3D ( opts & ~O_NONBLOCK );

  fcntl ( sock,
    F_SETFL,opts );

}

bool bt_sniffer::create()
{
    if((sock =3D socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI)) < 0)
    {
      throw btsnifferException ( "Error creating socket" );
      return false;
    }
  one =3D 1;
  if(setsockopt(sock, SOL_HCI, HCI_DATA_DIR, &one, sizeof(one)) < 0)
    {
      throw btsnifferException ( "Can't enable data direction info" );
      return false;
    }
  one =3D 1;
  if(setsockopt(sock, SOL_HCI, HCI_TIME_STAMP, &one, sizeof(one)) < 0)
    {
      throw btsnifferException ( "Can't enable time stamp" );
      return false;
    }

  hci_filter_clear(&filter);
  hci_filter_all_ptypes(&filter);
  hci_filter_all_events(&filter);

  if(setsockopt(sock, SOL_HCI, HCI_FILTER, &filter, sizeof(filter)) < 0)
    {
      throw btsnifferException ( "Can't set HCI filter" );
      return false;
    }


  addr.hci_family =3D AF_BLUETOOTH;
  addr.hci_dev =3D 0;

  if(bind(sock, (struct sockaddr *)&addr, sizeof(addr)) < 0)
    {
      throw btsnifferException ( "Bind error" );
      return false;
    }
    ioctl(sock, HCISETRAW);

    return true;
}
-------------------------------------------------------------------------=
-
---- socket.cpp ----
// Implementation of the Socket class.


#include "Socket.h"
#include "string.h"
#include <string.h>
#include <errno.h>
#include <fcntl.h>
#include <iostream.h>

using namespace std;

Socket::Socket() :
  m_sock ( -1 )
{

  memset ( &m_addr,
     0,
     sizeof ( m_addr ) );

}

Socket::~Socket()
{
  if ( is_valid() )
    ::close ( m_sock );
}

bool Socket::create()
{
  m_sock =3D socket ( AF_INET,
        SOCK_STREAM,
        0 );

  if ( ! is_valid() )
    return false;


  // TIME_WAIT - argh
  int on =3D 1;
  if ( setsockopt ( m_sock, SOL_SOCKET, SO_REUSEADDR, ( const char* ) =
&on,
sizeof ( on ) ) =3D=3D -1 )
    return false;


  return true;

}



bool Socket::bind ( const int port )
{

  if ( ! is_valid() )
    {
      return false;
    }



  m_addr.sin_family =3D AF_INET;
  m_addr.sin_addr.s_addr =3D INADDR_ANY;
  m_addr.sin_port =3D htons ( port );
  memset(&(m_addr.sin_zero), '\0', 8);
  int bind_return =3D ::bind ( m_sock,
           ( struct sockaddr * ) &m_addr,
           sizeof ( m_addr ) );


  if ( bind_return =3D=3D -1 )
    {
      return false;
    }

  return true;
}


bool Socket::listen() const
{
  if ( ! is_valid() )
    {
      return false;
    }

  int listen_return =3D ::listen ( m_sock, MAXCONNECTIONS );


  if ( listen_return =3D=3D -1 )
    {
      return false;
    }

  return true;
}


bool Socket::accept ( Socket& new_socket ) const
{
  int addr_length =3D sizeof ( m_addr );
  new_socket.m_sock =3D ::accept ( m_sock, ( sockaddr * ) &m_addr, ( =
socklen_t
* ) &addr_length );

  if ( new_socket.m_sock <=3D 0 )
    return false;
  else
    return true;
}


bool Socket::send ( const std::string s ) const
{
  int status =3D ::send ( m_sock, s.c_str(), s.size(), MSG_NOSIGNAL );
  if ( status =3D=3D -1 )
    {
      return false;
    }
  else
    {
      return true;
    }
}


int Socket::recv ( std::string& s ) const
{
  char buf [ MAXRECV + 1 ];

  s =3D "";

  memset ( buf, 0, MAXRECV + 1 );

  int status =3D ::recv ( m_sock, buf, MAXRECV, 0 );

/* if ( status =3D=3D -1 )
    {
// std::cout << "status =3D=3D -1 errno =3D=3D " << errno << " in =
Socket::recv\n";
      return 0;
    }
  else if ( status =3D=3D 0 )
    {
      return 0;
    }
  else
    {
*/ s =3D buf;
      return status;
// }
}



bool Socket::connect ( const std::string host, const int port )
{
  if ( ! is_valid() ) return false;

  m_addr.sin_family =3D AF_INET;
  m_addr.sin_port =3D htons ( port );

  int status =3D inet_pton ( AF_INET, host.c_str(), &m_addr.sin_addr );

  if ( errno =3D=3D EAFNOSUPPORT ) return false;

  status =3D ::connect ( m_sock, ( sockaddr * ) &m_addr, sizeof ( m_addr =
)
);

  if ( status =3D=3D 0 )
    return true;
  else
    return false;
}

void Socket::set_non_blocking ( const bool b )
{

  int opts;

  opts =3D fcntl ( m_sock,
     F_GETFL );

  if ( opts < 0 )
    {
      return;
    }

  if ( b )
    opts =3D ( opts | O_NONBLOCK );
  else
    opts =3D ( opts & ~O_NONBLOCK );

  fcntl ( m_sock,
    F_SETFL,opts );

}

bool Socket::sendall( const std::string s) const
{
  int total =3D 0;
  char * cstr =3D s.c_str();
  int bytesleft =3D s.length();
  int len =3D s.length();
  int n;

  while( total < len ) {
     n =3D ::send(m_sock, cstr + total, bytesleft, 0);
     if( n =3D=3D -1 ) break;
     total +=3D n;
     bytesleft -=3D n;
  }

  len =3D total;

  return !(n=3D=3D-1);

}
--------------------------------------------------------
--- THE PROGRAM PRODUCED THIS HCIDUMP ---
HCIDump - HCI packet analyzer ver 1.16
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Event: Connect Request (0x04) plen 10
< HCI Event: Connect Complete (0x03) plen 11
< HCI Event: Connect Request (0x04) plen 10
< HCI Event: Connect Complete (0x03) plen 11
< HCI Event: Connect Request (0x04) plen 10
< HCI Event: Connect Complete (0x03) plen 11
< HCI Event: Connect Request (0x04) plen 10
< HCI Event: Connect Complete (0x03) plen 11
< HCI Event: Connect Request (0x04) plen 10
< HCI Event: Connect Complete (0x03) plen 11
< HCI Event: Connect Request (0x04) plen 10
< HCI Event: Connect Complete (0x03) plen 11
< HCI Event: Connect Request (0x04) plen 10
< HCI Event: Connect Complete (0x03) plen 11
> HCI Event: Connect Request (0x04) plen 10
> HCI Event: Connect Complete (0x03) plen 11
> HCI Event: Connect Request (0x04) plen 10
> HCI Event: Connect Complete (0x03) plen 11
> HCI Event: Connect Request (0x04) plen 10
> HCI Event: Connect Complete (0x03) plen 11
> HCI Event: Connect Request (0x04) plen 10
> HCI Event: Connect Complete (0x03) plen 11
> HCI Event: Connect Request (0x04) plen 10
> HCI Event: Connect Complete (0x03) plen 11
> HCI Event: Connect Request (0x04) plen 10
> HCI Event: Connect Complete (0x03) plen 11
> HCI Event: Connect Request (0x04) plen 10
> HCI Event: Connect Complete (0x03) plen 11
> HCI Event: Connect Request (0x04) plen 10
> HCI Event: Connect Complete (0x03) plen 11
> HCI Event: Connect Request (0x04) plen 10
> HCI Event: Connect Complete (0x03) plen 11
> HCI Event: Connect Request (0x04) plen 10
> HCI Event: Connect Complete (0x03) plen 11
-------------------------------------------------------------------------=
---
-
---- AND THIS OUTPUT ----
Net-Gage testing program
-------------------------
[1] -- Connect to host
[2] -- Wait for connections
[3] -- Test console
[4] -- Other tests
[0] -- Quit
 Select option: 2
Waiting for connections at port 1984 ...
Connection complete!.
---------------------
Running .....
<Press Ctrl-C to abort the program>
TCP Data received:
+=DCW`
TCP Data received:
                   )
TCP Data received:
+=DCW`
TCP Data received:
                   *
TCP Data received:
+=DCW`
TCP Data received:
                   )
TCP Data received:
+=DCW`
TCP Data received:
                   *
TCP Data received:
+=DCW`
TCP Data received:
                   )
TCP Data received:
+=DCW`
TCP Data received:
                   *
TCP Data received:
+=DCW`
TCP Data received:
                   )
BT Data received:
:=F5W`
BT Data received:
                  (
BT Data received:
:=F5W`
BT Data received:
                  )
BT Data received:
:=F5W`
BT Data received:
                  (
BT Data received:
:=F5W`
BT Data received:
                  )
BT Data received:
:=F5W`
BT Data received:
                  (
BT Data received:
:=F5W`
BT Data received:
                  )
BT Data received:
:=F5W`
BT Data received:
                  (
BT Data received:
:=F5W`
BT Data received:
                  )
BT Data received:
:=F5W`
Connection closed.
Thank you for testing this program!






-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
