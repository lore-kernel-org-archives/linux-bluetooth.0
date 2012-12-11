Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAEoLCeYkpmXysL5M-2RW=MYaGcAt3Maqa-qbhzumtczNmPqewg@mail.gmail.com>
References: <CAEoLCeYkpmXysL5M-2RW=MYaGcAt3Maqa-qbhzumtczNmPqewg@mail.gmail.com>
From: XIAN PAN <panxian1212@gmail.com>
Date: Tue, 11 Dec 2012 16:56:15 -0500
Message-ID: <CAEoLCebGz+pE0fV_558prbY=5SODYrrKMHP-B7cqHLR1+gfjBQ@mail.gmail.com>
Subject: Problem on setting up l2cap connection on different version of Bluez
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>
Content-Type: multipart/alternative; boundary=f46d042ef46f708e6804d09ac1d8
List-ID: <linux-bluetooth.vger.kernel.org>

--f46d042ef46f708e6804d09ac1d8
Content-Type: text/plain; charset=ISO-8859-1

Hi,

My question is about the Bluetooth HID device simulation, for example, let
a computer working as a faked Bluetooth HID device. I study the l2test.c
file. My simulation program first finish hid service record registration,
and then calls l2cap_listen function (similar to the do_listen function in
l2test.c) to wait a connection request. If there is a connection
requirement, the simulation program calls the l2cap_accept function to set
up a connection.

My problem is: the simulation program only can work on Ubuntu 8.04 (kernel
2.6.24.29 and bluez 2.25). I try it on other OS such as Ubuntu 10.04,
Fedora 13, Opensuse 11.1 (kernel 2.6x and bluez 4.8), none of them can
work. It looks like no l2cap requirement coming that my program always wait
for accepting l2cap requirement. That seems I miss something in the program
that it cannot work with the latest Bluez. In fact, I search a lot on
Internet and read other similar programs, such as hidclient program (
http://anselm.hoffmeister.be/computer/hidclient/index.html.en) and
xkbdbthid (http://www.mulliner.org/bluetooth/xkbdbthid.php). Unfortunately,
those programs have the same problem as I meet: Only can work on old Bluez.
I really have not clue for this problem.

The simulation program first finish HID Mouse Service Record registration,
and then calls l2cap_listen function to wait a connection. If there is a
connection requirement, the simulation program calls the l2cap_accept
function. Those functions are taken from bluez and bluez-utils. (for
convenience, the simulation program is in the attachment). If the
simulation program runs on Ubuntu 10.04 or Fedora 13, it will wait there
forever, even if another computer already sends a connection requirement.
It looks like that the simulation program stops on l2cap_listen and never
wakes up to call the l2cap_accept function. What I miss in this process???

Thanks for your kind help.

Sincerely,
Xian

--f46d042ef46f708e6804d09ac1d8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><div>Hi,</div><div>=A0</div><div>My question is =
about=A0the Bluetooth HID device simulation, for example, let a computer wo=
rking=A0as a faked Bluetooth HID device. I study the l2test.c file. My simu=
lation program first finish=A0hid service record registration, and then cal=
ls l2cap_listen function (similar to the do_listen function in l2test.c) to=
 wait a connection request. If there is a connection requirement, the simul=
ation program calls the l2cap_accept function to set up a=A0connection.=A0 =
</div>


<div>=A0</div><div>My problem is: the simulation program only can work on U=
buntu 8.04 (kernel 2.6.24.29 and bluez 2.25). I try it on other OS such as =
Ubuntu 10.04, Fedora 13, Opensuse 11.1 (kernel 2.6x and bluez 4.8), none of=
 them can work. It looks like no l2cap requirement coming that my program a=
lways wait for=A0accepting=A0l2cap requirement.=A0That seems I miss somethi=
ng in the program that it cannot work with the latest Bluez. In fact, I sea=
rch a lot on Internet and read other similar programs, such as hidclient pr=
ogram (<a href=3D"http://anselm.hoffmeister.be/computer/hidclient/index.htm=
l.en" target=3D"_blank">http://anselm.hoffmeister.be/computer/hidclient/ind=
ex.html.en</a>) and xkbdbthid (<a href=3D"http://www.mulliner.org/bluetooth=
/xkbdbthid.php" target=3D"_blank">http://www.mulliner.org/bluetooth/xkbdbth=
id.php</a>). Unfortunately, those programs have the same problem as I meet:=
 Only can work on old Bluez. I really have not clue for this problem.<br>


<br>The simulation program first finish HID Mouse Service Record registrati=
on, and then calls l2cap_listen function to wait a connection. If there is =
a connection requirement, the simulation program calls the l2cap_accept fun=
ction. Those functions are taken from bluez and bluez-utils. (for convenien=
ce, the simulation program is in the attachment). If the simulation program=
 runs on Ubuntu 10.04 or Fedora 13, it will wait there forever, even if ano=
ther computer already sends a connection requirement. It looks like that th=
e simulation program stops on l2cap_listen and never wakes up to call the l=
2cap_accept function. What I miss in this process??? </div>


<div>=A0</div><div>Thanks for your kind help.</div><div>=A0</div><div>Since=
rely,</div><div>Xian<br>
</div></div>

--f46d042ef46f708e6804d09ac1d8--
