Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20050714093139.3323.qmail@web52814.mail.yahoo.com>
From: Naved Aziz <no2alikebd@yahoo.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-devel] read data from one device to another over rfcomm
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
Date: Thu, 14 Jul 2005 02:31:39 -0700 (PDT)

Hi,

I am developing some applications using BlueZ.  The
developer board is Axis Developer 82+.  

The following is the code for one of the functions. 
Basically, there are two axis boards, one is acting as
a server, the other, a client.  Upon establising a
connection with the server, the client receives a menu
that shows the actions it can take: run a command on
the other server, receive a file from the server, send
a file to the server.

This is the code for the client after connecting to
the server:

	while (1)
	  {	    
	    memset (optn_buff, 0, 3 );
	    
            printf ("What do you want to do (type in
the option number)?  Press CTRL-C for hang-up\n");
            printf ("\t(1) Run a command\n");
	    printf ("\t(2) Transfer a file from here to
there\n");
	    printf ("\t(3) Transfer a file from there to
here\n");
	    
	    gets(optn);                                // get
option
	    
	    optn_int = atoi(optn);
	    
	    if (optn_int < 1 || optn_int > 3)
	      {
	        printf ("Choose the option that's
given\n\n");
		continue;
	      }
	      
	    optn_str = sprintf(optn_buff, "%d", optn_int);   
      // convert optn to string 
	    chk_write = write (sk, optn_buff, optn_str);     
  // send optn to server
	    
	    switch (optn_int)
	      {
	        case 1:
		  rcmdc (sk);                                   //
run command on server
		  break;
		case 2:
		  snd (sk);                                     //
send file from here
		  break;
		case 3:
		  rec (sk);                                     //
receive file from there
		  break;    
	      }
	  }  

optn_buff is an array of unsigned char type, of size
3.  It sends the choice made by the client to the
server.

The following is the code from the server:

	while (1)
	  {	    
	    memset (optn_buff, 0, 3 );
	    
	    chk_read = read (sk, optn_buff, 1);	             
 // read option chosen by the client
	    optn = atoi(optn_buff);                          
 // convert buffer data to int    
	    
	    switch (optn)
	      {
	        case 1:
		  rcmds (sk);                                   //
run command on server
		  break;
		case 2:
		  rec (sk);                                     //
receive file 
		  break;
		case 3:
		  snd (sk);                                     //
send file 
		  break;    
	      }
	   }  	

After connection is made, the server waits to receive 
the instruction to be executed as requested by the
client.  

The problem I am facing is with the read statements:  
 The devices do not read what's being sent to them. 
The queer thing is, if I use the same code to connect
and play with a phone, the read statements execute.  I
have been able to send and receive data (using read
and write as above) with a number of phones.  So, the
boards can't read when they are being written to, but
the phones can read when they're being written to.

Has anyone faced problems of this sort?  Please spare
a minute of your time for me if you have. 

Thanks and sincerely,

Naved  

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
