Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: =?iso-8859-1?Q?Riikka_Jylh=E4?= <jylhar@ac.tut.fi>
To: <bluez-users@lists.sourceforge.net>
Message-ID: <003a01c38673$a6684c40$792ae682@ac.tut.fi>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [Bluez-users] SCO strange transmission, timing problem?
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 29 Sep 2003 13:22:56 +0300

Hi,

I've been working with Bluez-SCO for a while and I've managed to get it
working as I wanted, that is sending raw data with transparent voice
coding. The system started working fine as the disturbing WLAN changed
its channel.

But it is only working with a code that is little changed hstest.c. My
own program that actually does something sensible is working as it was
disturbed. That is, there are some good pieces of SCO-stream but it
seems like the same data is handled over and over again at the
receiving.=20

This is working
************************************************
...=20

       maxfd =3D (rd > sd) ? rd : sd;
        luku =3D 0;
        while (!terminate) {

                FD_ZERO(&rfds);
                FD_SET(rd, &rfds);
                FD_SET(sd, &rfds);

                timeout.tv_sec =3D 0;
                timeout.tv_usec =3D 10000;

                if ((sel =3D select(maxfd + 1, &rfds, NULL, NULL,
&timeout)) > 0)\
 {

                        if (FD_ISSET(sd, &rfds)) {
                                memset(buf, 0, sizeof(buf));
                                // reading from SCO
                                // printing the stuff


                                rlen =3D read(sd, buf, sizeof(buf));
                                printf("read from SCO: %s\n", buf);
                                if (rlen > 0)
                                        switch (mode) {
                                          // reading data from file and
                                          // sending it to the remote
side       =20

                                        case PLAY:
                                                rlen =3D read(fd, buf,
rlen);
                                                if(rlen > 0){
                                                  luku +=3D rlen;
                                                  wlen =3D write(sd, =
buf,
rlen);
                                                }else{
luku);
                                                  close(sd);
                                                  sleep(2);
                                                  close(rd);
                                                  close(fd);
                                                  return 0;
                                                }

                                                  break;

			        // printing the stuff that came
			        // from SCO and sending it back
			        // writing data also to a file

                                        case RECORD:
                                          printf("read: %s\n", buf);
                                                wlen =3D write(fd, buf,
rlen);
                                                wlen =3D write(sd, buf,
rlen);
                                                break;
                                        default:
                                                break;
                                        }
                        }
                }
        }
...
************************************************

This isn't working (client side, the server code is basically the same)
Two programs that send 200 packets and receive the other ends packets.
************************************************
...
  while(data < 200) { // sending 200 packets

    /* loop that waits for next transmission =3D10ms from the previous*/

    ...

    // reading from sco

			// connection is a struct that contains
			// for example file descriptors and info
			// about data stream

    if(read_sco(&data_read, &time_read, &connection) < 0) {
      //      printf("Read SCO failed\n");                             =20
    }
    else {
      //      printf("SUCCESS\n");

      ++read_succees;

    }


    if(send_sco(data, &time_send, &connection) < 0) {
      //printf("Send SCO failed\n");

    }
    else {
      ++send_succees;
    }
    //    printf("OK\n");


    ++data;
  }
...
***********************************************

send_sco function is constructing a proper packet from time and data
information and using write-function

read_sco function has a system that finds packets from the datastream
and transforms the packet to a time and data information.=20

So basically my non-working code is the same as the working one. Only
difference is that timing is made differently and there is much stuff
added between the socket commands read and write.

So if the writer of hstest.c could give me a hint what's wrong. I
couldn't figure out what FD_ commands are for so I just took them to my
code. What do they do? Are they essential?

Is it possible that timing is the problem? My programs seems to manage
the sending and receiving in 10 ms so that shouldn't be a problem. Are
there any other timing issues to consider?

--
Riikka Jylh=E4




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
