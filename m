Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <c6a2f99a0604192346k686af0b9i969f44d128ab289c@mail.gmail.com>
From: "Eric Munson" <ebmunson@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Programming in C with Bluetooth Sockets
In-Reply-To: <c6a2f99a0604191341g706c5a51la3e737f67a1dcdd2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <c6a2f99a0604181925x1b61f8fer9b44102b3df4da7b@mail.gmail.com>
	 <fe0a97c20604182118w6f25db3ei437dde8f23c93436@mail.gmail.com>
	 <c6a2f99a0604190804k7de31858i94b74e2d06b3ff11@mail.gmail.com>
	 <ef9938ec0604190956r40a902b5sce596c16e40ce8e1@mail.gmail.com>
	 <c6a2f99a0604191126p744f86f5xa9c1a361381fa23a@mail.gmail.com>
	 <ef9938ec0604191132v66b0e299nbd4f50071b907c2e@mail.gmail.com>
	 <c6a2f99a0604191341g706c5a51la3e737f67a1dcdd2@mail.gmail.com>
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
Date: Wed, 19 Apr 2006 23:46:29 -0700

That did solve the problem, thanks again for catching such a silly mistake.

Eric

On 4/19/06, Eric Munson <ebmunson@gmail.com> wrote:
> Thanks very much for catching this, I believe that it is the problem.
> I will change my code and give it a try.
>
> Eric
>
> On 4/19/06, Albert Huang <albert@csail.mit.edu> wrote:
> >
> >
> > >                bytes_read =3D read(client, buf + count, sizeof(buf) -
> > count);
> >
> >
> > sizeof(buf) will always return  4 because buf was allocated as a char* =
and
> > not a char[]
> > So it's never trying to read more than 4 bytes at a time
> >
> > -albert
> >
> >
>


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
