Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: =?iso-8859-1?q?Barth=E9l=E9my_Lemaire?= <barthelemy.lemaire@fpms.ac.be>
To: Bluez-devel@lists.sourceforge.net
Date: Tue, 13 Mar 2007 15:54:12 +0100
MIME-Version: 1.0
Message-Id: <200703131554.12347.barthelemy.lemaire@fpms.ac.be>
Subject: [Bluez-devel] Communicating with a Bluetooth Module - SPP profile
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello,

I would like to communicate with a PROMI-ESD-02 Bluetooth module. It suppor=
ts =

the following Bluetooth protocols
- RFCOMM
- L2CAP =

- SDP
The following profiles are accepted : =

- General Acces Profile
- SPP

In order to use the SPP, I coded a little program (see below).

Basically, it does a fork: the father process launchs the rfcomm program =

(rfcomm connect ...) while the son process connects, after 2 seconds, to =

the /dev/rfcomm0 special file (open system call) and writes to it the =

string "hello" (write system call) .

When this program is launched , it does its job, but I need to launch it in=
 a =

perl CGI script (exec ./program;). In this last case, there is a problem : =
it =

seems that the rfcomm program connects to the bluetooth module and then =

immediately disconnects, preventing the son process from sending the "hello=
" =

writing to the module.

So, I have several questions :

1) Is this method  the best coding practice in C to communicate via the SPP =

with a Bluetooth module? =


2) If not, how can I achieve this more efficiently ?(i.e. could you point t=
o a =

example of best coding practice?)

Thanks in advance,

Best regards,

Barth=E9l=E9my Lemaire

***
int
main(int argc, char *argv[])
{
        if (argc !=3D 2)
        {
                printf("USAGE : %s BDADDR\n\n", argv[0]);
                exit(-1);
        }
        int pid, ret, fd, i;

        pid =3D fork();
        assert(pid >=3D 0);
        if (pid =3D=3D 0)
        {

                sleep(2);
                printf("Lancement du fils ...\n");
                printf("Ouverture du port s=E9rie\n");
                fd =3D ouverture();
                assert(fd > 0);
                printf("Envoi d'une cha=EEne de caract=E8res\n");
                envoi(fd, "hello", 5);
                fermeture(fd);
                kill(getppid(), SIGINT);
        } else
        {
                /* P=E8re */
                printf("Lancement du p=E8re ...\n");
                ret =3D execl("/usr/bin/rfcomm", "rfcomm", "connect", PORTS=
ERIE,
                            argv[1], "1", (char *) NULL);
                assert(ret > 0);
                wait(NULL);
                ret =3D execl("/usr/bin/rfcomm", "rfcomm", "release",
                            PORTSERIE);
                assert(ret > 0);
        }
        return EXIT_SUCCESS;
}                               /* ----------  end of function =

main  ---------- */
***

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
