Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <c6a2f99a0604191126p744f86f5xa9c1a361381fa23a@mail.gmail.com>
From: "Eric Munson" <ebmunson@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Programming in C with Bluetooth Sockets
In-Reply-To: <ef9938ec0604190956r40a902b5sce596c16e40ce8e1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <c6a2f99a0604181925x1b61f8fer9b44102b3df4da7b@mail.gmail.com>
	 <fe0a97c20604182118w6f25db3ei437dde8f23c93436@mail.gmail.com>
	 <c6a2f99a0604190804k7de31858i94b74e2d06b3ff11@mail.gmail.com>
	 <ef9938ec0604190956r40a902b5sce596c16e40ce8e1@mail.gmail.com>
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
Date: Wed, 19 Apr 2006 11:26:07 -0700

This is the function run by the bluetooth device that will recieve the data=
.

char* BT_Target()
{
       int s, client, bytes_read, count =3D 0;
       char * buf;
       struct sockaddr_rc loc_addr =3D { 0 }, rem_addr =3D { 0 };
       int opt =3D sizeof(rem_addr);
       unsigned int max_count;

       //attempt to allocate reception buffer
       buf =3D (char *)calloc(MAX_MSG, 1);

       if(buf =3D=3D NULL)
       {
               perror("No memory!");
               return("No memory!");
       }

       //attempt to allocate socket
       s =3D socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);

       if(s < 0)
       {
               perror("socket failed to open:");
               return("socket failed to open");
       }

       loc_addr.rc_family =3D AF_BLUETOOTH;
       loc_addr.rc_bdaddr =3D *BDADDR_ANY;
       loc_addr.rc_channel =3D (uint8_t) RFCOMM_CHANNEL;

       //attempt to bind the socket for a maximum number of attempts
       for( count =3D 0; count < MAX_ATTEMPTS && bind(s, (struct sockaddr
*)&loc_addr, sizeof(loc_addr)) < 0; count++);

       //if we tried to open the socket but failed
       if( count =3D=3D MAX_ATTEMPTS )
       {
               perror("unable to bind socket: ");
               close(s);
               free(buf);
               return "unable to bind socket";
       }

       //attempt to listen
       if(listen(s, 1) < 0)
       {
               perror("listen failed: ");
               close(s);
               free(buf);
               return "listen failed.";
       }

       //attempt to accept the socket
       rem_addr.rc_family =3D AF_BLUETOOTH;
       rem_addr.rc_bdaddr =3D *BDADDR_ANY;
       rem_addr.rc_channel =3D (uint8_t) RFCOMM_CHANNEL;

       client =3D accept(s, (struct sockaddr *)&rem_addr, &opt);

       //if we have created a connection
       //we need to recieve the transmission length into max_count
       if(client >=3D 0)
       {
               count =3D 0;
               fprintf(stderr,"Got a connection\n");
               read(client, &max_count, sizeof(unsigned int));
               printf( "Message size: %d\n", max_count );
               close( client );

       }
       //the accept has failed
       else
       {
               perror("accept failed: ");
               close(s);
               free(buf);
               return("accept failed");
       }

       //while we have not recieved the entire message, get the next part
       while( count < max_count &&
                ( client =3D accept(s, (struct sockaddr*)&rem_addr, &opt) )=
 >=3D 0 )
       {
               bytes_read =3D read(client, buf + count, sizeof(buf) - count=
);

               fprintf(stderr, "got %d bytes this time\n", bytes_read);
               count +=3D bytes_read;
               fprintf(stderr, "recieved %d [%s] so far\n", count, buf);
               close( client );

               if(bytes_read < 0)
               {
                       perror("socket issue.");
                       fprintf(stderr, "We have socket problems.\n");
                       close(s);
                       free(buf);
                       close(client);
                       return("We have socket Problems.");
               }
       }

       close(s);
       close(client);

       return "Success";
}

And this is the function that will send the data.
char* BT_Source(char* fname, int iter, char* tMAC)
{
       struct sockaddr_rc addr =3D { 0 };
       int s, status, count =3D 0, fd;
       char* dest =3D tMAC;
       struct stat *stats;
       unsigned int len =3D 0;
       char* buf;

       //attempt to allocate a socket
       s =3D socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
       if(s < 0)
       {
               perror("error creating socket: ");
               return "socket creation failed.";
       }

       // set the connection parameters (who to connect to)
       addr.rc_family =3D AF_BLUETOOTH;
       addr.rc_channel =3D (uint8_t) RFCOMM_CHANNEL;

       fprintf(stderr, "The dest addr is now %s\n", dest);
       str2ba(dest, &addr.rc_bdaddr);

       //attempt to connect the socket for our maximum number of times
       status =3D connect(s, (struct sockaddr *)&addr, sizeof(addr));
       for(count =3D 0; status !=3D 0 && count < MAX_ATTEMPTS;)
       {
               perror("retrying connection: ");

               //if the socket is busy or the host is down, close and reope=
n
               if(!(errno =3D=3D EBUSY || errno =3D=3D EHOSTDOWN))
               {
                       close(s);
                       s =3D socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCO=
MM);
                       if(s < 0)
                       {
                               perror("error creating socket: ");
                               return "socket creation failed.";
                       }
                       count++;
               }

               status =3D connect(s, (struct sockaddr *)&addr, sizeof(addr)=
);
       }

       //if the socket was opened properly, send a message
       if(status =3D=3D 0)
       {
               count =3D 0;

               //get the file size and send it to the client
               stat(fname, stats);
               len =3D stats->st_size;
               fprintf(stderr, "The length in bytes is %d\n", len);
               write(s, &len, sizeof(unsigned int));

               //open the file
               if((fd =3D open(fname, O_RDONLY)) =3D=3D NULL)
               {
                       perror( "Cannot open file for reading" );
                       close( s );
                       return "failed";
               }

               //attempt to allocate reception buffer
               buf =3D (char *)calloc( MAX_MSG + 1, 1 );

               if( buf =3D=3D NULL )
               {
                       perror( "out of memory" );
                       close( fd );
                       close( s );
                       return "failed";
               }

               //while we still have message to send
               while((in =3D read(fd, buf, MAX_MSG)) > 0)
               {
                       //close previous socket connection to force a flush
                       close( s );

                       //allocate a socket
                       s =3D socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCO=
MM);
                       if(s < 0)
                       {
                               perror("error creating socket: ");
                               return "socket creation failed.";
                       }

                       //connect the socket
                       status =3D connect(s, (struct sockaddr *)&addr,
sizeof(addr));
                       for(count =3D 0; status !=3D 0 && count < MAX_ATTEMP=
TS;)
                       {
                               perror("retrying connection: ");

                               if(!(errno =3D=3D EBUSY || errno =3D=3D EHOS=
TDOWN))
                               {
                                       close(s);
                                       s =3D socket(AF_BLUETOOTH,
SOCK_STREAM, BTPROTO_RFCOMM);
                                       if(s < 0)
                                       {
                                               perror("error creating
socket: ");
                                               return "socket creation fail=
ed.";
                                       }
                                       count++;
                                       sleep( 1 );
                               }

                               status =3D connect(s, (struct sockaddr
*)&addr, sizeof(addr));
                       }

                       if( status < 0 )
                       {
                               perror("message failed: ");
                               close(s);
                               close(fd);
                               fprintf(stderr, "failed connecting, I
tried %d times.\n", count);
                               return "uh oh, that message did not go throu=
gh";
                       }

                       //write the next message segment
                       fprintf(stderr,"data read '%s'\n", buf);
                       count =3D write(s, buf, MAX_MSG);
                       fprintf(stderr,"contents of in: %d, %d bytes
were written\n", in, count);
               }
       }
       else if(status < 0)
       {
               perror("message failed: ");
               close(s);
               close(fd);
               fprintf(stderr, "failed connecting, I tried %d times.\n", co=
unt);
               return "uh oh, that message did not go through";
       }

       fprintf(stderr, "message sent\n");
       close(s);
       close(fd);

       return strdup("Success");
}

This is the latest iteration where the connection is stopped after
each 4 byte transmission and restarted before the next.


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
