Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="============_-1107093994==_============"
Message-Id: <v04020a1ebe030f7ac594@[192.168.49.19]>
To: bluez-devel@lists.sourceforge.net
From: Bob Gustafson <bobgus@rcn.com>
Subject: Re: [Bluez-devel] btsco under FC3
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
Date: Thu, 6 Jan 2005 10:21:22 -0600

--============_-1107093994==_============
Content-Type: text/plain; charset="us-ascii"

Building a new directory from CVS (with old directory as btsco.save)

[root@hoho2 btsco]# cd ..
[root@hoho2 blue]# diff -Naur btsco btsco.save > btsco.p

[root@hoho2 blue]# ls -l btsco.p
-rw-r--r--  1 root root 1015578 Jan  6 09:51 btsco.p
[root@hoho2 blue]#

Not so useful right now (huge). Need to extract the needful.
See attached file 'pspit.p'

Now, execute these commands

[root@hoho2 blue]# patch -p0 < pspit.p
[root@hoho2 blue]# cd btsco
[root@hoho2 btsco]# make 2>&1 | tee make.out
...
...
libtool --mode=link gcc  -Wall -O2   -o a2play  a2play.o -lbluetooth
-lasound -l
m -ldl -lpthread
gcc -Wall -O2 -o a2play a2play.o  -lbluetooth -lasound -lm -ldl -lpthread
make[2]: Leaving directory `/home/user1/blue/btsco'
make[1]: Leaving directory `/home/user1/blue/btsco'
[root@hoho2 btsco]#

Looks a lot better.

(Keep in mind that the patch is useful only after having done a failed make
at least once.. :-( )

Now, just do the 'make install' phases

(I did other up2dates besides libao-devel - if you have problems, let me
know and I will try to reconstruct what I did)

BobG
--============_-1107093994==_============
Content-Id: <v04020a1ebe030f7ac594@[192.168.49.19].0.0>
Content-Type: application/mac-binhex40; name="pspit.p"
Content-Disposition: attachment; filename="pspit.p"
 ; modification-date="Thu, 6 Jan 2005 10:21:43 -0600"

(This file must be converted with BinHex 4.0)

:"h"cF'Pd,R!!9%9B9%0A588!!!!!#&3!!!!!Ab9ND@CQ)#e1BA9b)'*dFf0[,de
KDf9QD@aP)'*dFf0[,R0KGQ8[6@&VC@CTE'8+,5dY)'*dFf0[,deKDf9QD@aP#6)
`-$8Y-$%Y-$BJ-$Nk0$3k-c%Z16-h0$8f0c!j)#d`0M!`#LXV+b"LG(0MEbjcBAC
P,deKDf9QD@aP#6)`-$8Y-$%Y-$8J-6)k-M%k-$-Z-$!`-$!`-$!`)#d`0M!`#N"
!)#dh-L`a-#!V0c)X-6!J3%!+)%4&4N&96&4I58j$6&9%49-J25!Y55iJ,8NN+(0
bBf4TFLNJ,8NZ#L"NCA"MEfe`)$d+)'&YAepNCA"QD@aPFepYBAPLC5!p#Le$6de
358a&)$dJ*#K$3bNJ*#K%48C6+5!N+%4&4N&96&4I58j$6&9%49-T)#3S58j$6&9
%49-T)#3S38eI3e"34Na"4e-T)&`++d0269"*6%8J25"XD@*dEfpX)#dYE@pNC6e
MEfe`D@aP)#3S3d-T)#3S4%9'8bNJ*#K%48C"98a8AdP13da94%96+5!N+%P13da
94%96+5!N+%&0Ad038%C-38G6+5"F#L!**#K$8&"'6%&(8bNJ*#K"69p$4Na"4e-
T)#3S3dC-38G6+3SJ3d0-4#!p)#3S3d-T#Le-58j,)$dJ*#K$3da%+5!N+%&0Ad0
'6%&(8bNJ*#K$4Na"4e-T)#3S38eI6%4'6%&(8bNJ*#K-4%C-38G6+5!YEb!N3!S
V6%P15b!p)'aTBR4[Ef`J,5eYEf4P2@aTEQXJ*#K$3da%+5!N+%&0Ad0'6%&(8bN
J*#K$4Na"4e-T)#3S38eI6%4'6%&(8bNJ*#K-4%C-38G6+5!YEb!N3!SJ8dp98N0
&8b!p)'%bF'aKH5jM)'*dFf0[,Q-JBR4cBfmb,Q-+)%4*8e4I8dp98N0&8b!p)'%
bF'aKH5jM)'*dFf0[,Q-JBR4cBfmb,Q-+)&*&3e958dP@49p839*(4946)$dJB@a
X,A*PBh9bFfPfC5"MD'9MDbebC@0eFR0TGQ8JC(CT,A*PBh9bFfPfC5"F#Q4TCQB
J,8jKGA)JBR4cBfm[Ff*M,deKDf9QD@aP)'*dFf0[,R0KGQ8[Ff*M,deKDf9QD@a
P#LdY,5"LG(0MEbpcBQ-[6@&VC@CTE'8*-M!`05d`-5d`0L!`16Sd0$Sc-5ij0cB
d063d-c-J,6!f-$!++bXV)'*dFf0[,R0KGQ8[Ff*M,deKDf9QD@aP#6)`-$8Y-$%
Y-$8J-6)k-6!k-MNZ-$!`-$!`-$!`)#d`0M!`#N"!)#dh0L`a-#!V0cBX-6!J3%!
+)%4&4N&96&4I58j$6&9%49-J25!Y55iJ,8NN+(0bBf4TFLNJ,8NN+(4[F&pLG@P
XC'4TFLN+)'4PF'0[EA!J23SJB@eIAf4PF'CTE'9cAfeKH@*P)$d+,80269"*6%8
J25!N+%0$+5!N+%4&4P-T)#3S4%9'399-9&p*6N0-984&8bNJ*#K*6N0-984&8bN
J*#K"69p$8&"'6%&(8bNJA!SV3dp08%P-45!p)'aTBR4[Ef`J,5eYEf4P2@0[EA"
TE'8J*#K$3bNJ*#K%48C6+5!N+%4&4N&96&4I58j$6&9%49-T)#3S58j$6&9%49-
T)#3S38eI3e"34Na"4e-T)&`+)!NN+%038%C-38G6+5!N+%&0Ad0'6%&(8bNJ*#K
$4Na"4e-T#L"$3da%)$dJ*#K$3bN+,8a*6NXJ25!N+%0$6%3T)#3S38eI3dC-38G
6+5!N+%0'6%&(8bNJ*#K"69p-4%C-38G6+5!N+%a%4Na"4e-T)#e[)#4!#LY-58j
,)$dJE'PLG'p[E#!Y,@e[C'8pE'PZDb!N+%0$6%3T)#3S38eI3dC-38G6+5!N+%0
'6%&(8bNJ*#K"69p-4%C-38G6+5!N+%a%4Na"4e-T)#e[)#4!#L"66e953d96)$d
J*#KXD@*cBQ0IB9p66e953d96+5"bBh"XBANZBb"cBQ0NC@-ZBb"cBQ0PEQ-ZBb"
cBQ0TEQC[,Q-+)%4*8e4I8dp98N0&8b!p)#3SE'PLFf*MAf&I8dp98N0&8bNJFQ0
`E'&j,Q-JFf*MC'9M,Q-JFf*MC@jM,Q-JA!SJ#A0LBfPZCQmZB`T!3#!Y-6%a,$F
J+c%a-5`h)%"!#L"*6P0838a-Ae"56dG538dJ25!NHdP18e4"6%ap#L"*6P0838a
-Ae0$8NP39#!p)#4l58j69%&-6(d+)%P18e4"6%aI8e4559"I8&*24e*"65!p)#4
l8dK&6%ap)#3SD@jcG'&XE&pcD#NJ,@-J,A-+,8a%4Na"4e-J25!++da%4Na"4e-
J25!YE'&[#L"-58*23NT6)$dJ#L"-58*6)$dJ,@aKFfpeEQ3J,@aY)#eXC'`J,@a
`G'KbC@&N#L"-9%a*3Np#5P-J25!+3%!J,6%f-5`a-#!V-6Ba,$%`)%"!#L"dBA*
RCA4IB@aTBA-J25!+)'j[D@jcG&p-58*539**49-J25"XD@*cBQ-ZB3SJE'PLFf*
MAf&I8dp98N0&8b!p)(0LBbjS)(0LBbjM)(0LBepdB@*XCA-ZD!SYFf*MC'9MAda
%384%)$dJ3%&2Ada*3P0!)'aTBR0LBbjK#LYcBQ0NC@0I6%4"4%3J25"XD@*cBQ-
ZB3SJFf*MC@jMAda%384%)$dJE'PLFf*M,Q%+)(*MF'aKH9p-4%&%4#!p)#eXBQa
eCA4[Eh4S#Le"69p$4Na"4e-J25"!38pI3dC-38G63!SV38eI3dC-38G6)$dJ#L"
038P19%&*6N953da&38j'58a&8b!p)%eKDf9QD@aP,QPZ#L"KE'`k)'&XE#eKE3S
J#Yc1!!!!:
--============_-1107093994==_============--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
