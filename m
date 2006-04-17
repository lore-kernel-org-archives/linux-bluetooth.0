Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <6297d67c0604162151m1ec90cebh194f37f39f2a7929@mail.gmail.com>
From: "Mayank Batra" <mayankbatra@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] How to process fragmentation synchronously when two l2cap connections over one acl connection?
In-Reply-To: <ef9938ec0604130949q67168579m85a3eb9521cdae91@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_4871_2577433.1145249483911"
References: <9FBCE015AF479F46B3B410499F3AE05B011F0BCB@pdsmsx405>
	 <OF01649481.41C9F474-ON4825714F.003F0EC5-4825714F.004171CE@zte.com.cn>
	 <ef9938ec0604130949q67168579m85a3eb9521cdae91@mail.gmail.com>
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
Date: Mon, 17 Apr 2006 10:21:23 +0530

------=_Part_4871_2577433.1145249483911
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Albert,

I don't think each l2cap continuation fragment has the CID in it.
It is only the start fragment that has the CID in it. Refer to the
attached image.
At one instance of time we cannot receive two l2cap start fragments.
I mean once we get an l2cap start fragment, we can be rest assured
that the l2cap continuation packets that we will be receiving after
that belong to the same channel ID for which we recieved the start
fragment.
Thus Marcel correctly pointed out that we are not allowed to mix l2cap
fragments.

Regards,
Mayank


On 4/13/06, Albert Huang <albert@csail.mit.edu> wrote:
> l2cap packets are always identified by a channel ID, which is negotiated
> when each l2cap connection (channel) is established.  Continuation fragments
> always have the channel ID in the packet header, so there is no ambiguity
> over which continuation fragment belongs to which connection.  You should
> take another look at the L2CAP section in the core spec.
>
> -albert
>
>
> On 4/13/06, gao.yingbin@zte.com.cn <gao.yingbin@zte.com.cn > wrote:
> >
> >
> > Marcel & all,
> >   I'am puzzling over the following question. How to process fragmentation
> synchronously when two l2cap connections over one acl connection?
> >  in bluetooth specification, the continuing fragments of l2cap only can be
> identified by acl connection handles. so if two l2cap connections build over
> one acl conncetion (such as two l2cap connections bulid  between two
> bluetooth devices), and the two l2cap connections received continuing
> fragments synchronously，how can i identify which fragments belong the first
> l2caps connections and which fragments  belong the other?
> > thanks.
> >
> >
> >
> > --------------------------------------------------------
> > ZTE Information Security Notice: The
> information contained in this mail is
> solely property of the sender's organization. This
> mail communication is confidential.
> Recipients named above are obligated to maintain
> secrecy and are not permitted to disclose
> the contents of this communication to others.
> > This email and any files transmitted with it
> are confidential and intended solely for
> the use of the individual or entity to
> whom they are addressed. If you have
> received this email in error please notify
> the originator of the message. Any views
> expressed in this message are those of the
> individual sender.
> > This message has been scanned for viruses and Spam by
> ZTE Anti-Spam system.
> >
> >
>
>

------=_Part_4871_2577433.1145249483911
Content-Type: image/jpeg; name=l2cap_frag.JPG
Content-Transfer-Encoding: base64
X-Attachment-Id: f_em4bxx9y
Content-Disposition: attachment; filename="l2cap_frag.JPG"

/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRofHh0a
HBwgJC4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwhMjIyMjIy
MjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjL/wAARCACxAuIDASIA
AhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQA
AAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3
ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWm
p6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEA
AwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSEx
BhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElK
U1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3
uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD3+isP
xpPNa+BfENxbyyQzxaZcvHJGxVkYRMQQRyCDzmo/+EN0v/n61z/we3v/AMeoA6Ciuf8A+EN0v/n6
1z/we3v/AMeo/wCEN0v/AJ+tc/8AB7e//HqAOgorn/8AhDdL/wCfrXP/AAe3v/x6j/hDdL/5+tc/
8Ht7/wDHqAOgorn/APhDdL/5+tc/8Ht7/wDHqP8AhDdL/wCfrXP/AAe3v/x6gDoKK5//AIQ3S/8A
n61z/wAHt7/8eo/4Q3S/+frXP/B7e/8Ax6gDoKK5/wD4Q3S/+frXP/B7e/8Ax6j/AIQ3S/8An61z
/wAHt7/8eoA6Ciuf/wCEN0v/AJ+tc/8AB7e//HqP+EN0v/n61z/we3v/AMeoA6Ciuf8A+EN0v/n6
1z/we3v/AMeo/wCEN0v/AJ+tc/8AB7e//HqAOgorn/8AhDdL/wCfrXP/AAe3v/x6j/hDdL/5+tc/
8Ht7/wDHqAOgorn/APhDdL/5+tc/8Ht7/wDHqP8AhDdL/wCfrXP/AAe3v/x6gDoKK5//AIQ3S/8A
n61z/wAHt7/8eo/4Q3S/+frXP/B7e/8Ax6gDoKK5/wD4Q3S/+frXP/B7e/8Ax6j/AIQ3S/8An61z
/wAHt7/8eoA6Ciuf/wCEN0v/AJ+tc/8AB7e//HqP+EN0v/n61z/we3v/AMeoA6Ciuf8A+EN0v/n6
1z/we3v/AMeo/wCEN0v/AJ+tc/8AB7e//HqAOgorn/8AhDdL/wCfrXP/AAe3v/x6j/hDdL/5+tc/
8Ht7/wDHqAOgorn/APhDdL/5+tc/8Ht7/wDHqP8AhDdL/wCfrXP/AAe3v/x6gDoKK5//AIQ3S/8A
n61z/wAHt7/8eo/4Q3S/+frXP/B7e/8Ax6gDoKK5/wD4Q3S/+frXP/B7e/8Ax6j/AIQ3S/8An61z
/wAHt7/8eoA6Ciuf/wCEN0v/AJ+tc/8AB7e//HqP+EN0v/n61z/we3v/AMeoA6Ciuf8A+EN0v/n6
1z/we3v/AMeo/wCEN0v/AJ+tc/8AB7e//HqAOgorn/8AhDdL/wCfrXP/AAe3v/x6j/hDdL/5+tc/
8Ht7/wDHqAOgorn/APhDdL/5+tc/8Ht7/wDHqP8AhDdL/wCfrXP/AAe3v/x6gDoKK5//AIQ3S/8A
n61z/wAHt7/8eo/4Q3S/+frXP/B7e/8Ax6gDoKK5/wD4Q3S/+frXP/B7e/8Ax6j/AIQ3S/8An61z
/wAHt7/8eoA6Ciuf/wCEN0v/AJ+tc/8AB7e//HqP+EN0v/n61z/we3v/AMeoA6Ciuf8A+EN0v/n6
1z/we3v/AMeo/wCEN0v/AJ+tc/8AB7e//HqAOgorn/8AhDdL/wCfrXP/AAe3v/x6j/hDdL/5+tc/
8Ht7/wDHqAOgorn/APhDdL/5+tc/8Ht7/wDHqP8AhDdL/wCfrXP/AAe3v/x6gDoKK5//AIQ3S/8A
n61z/wAHt7/8eo/4Q3S/+frXP/B7e/8Ax6gDoKK5/wD4Q3S/+frXP/B7e/8Ax6j/AIQ3S/8An61z
/wAHt7/8eoA6Ciuf/wCEN0v/AJ+tc/8AB7e//HqP+EN0v/n61z/we3v/AMeoA6Ciuf8A+EN0v/n6
1z/we3v/AMeo/wCEN0v/AJ+tc/8AB7e//HqAOgorn/8AhDdL/wCfrXP/AAe3v/x6j/hDdL/5+tc/
8Ht7/wDHqAOgorn/APhDdL/5+tc/8Ht7/wDHqP8AhDdL/wCfrXP/AAe3v/x6gDoKK5//AIQ3S/8A
n61z/wAHt7/8eo/4Q3S/+frXP/B7e/8Ax6gDoKK5/wD4Q3S/+frXP/B7e/8Ax6j/AIQ3S/8An61z
/wAHt7/8eoA6Ciuf/wCEN0v/AJ+tc/8AB7e//HqP+EN0v/n61z/we3v/AMeoA6Ciuf8A+EN0v/n6
1z/we3v/AMeo/wCEN0v/AJ+tc/8AB7e//HqAOgorn/8AhDdL/wCfrXP/AAe3v/x6j/hDdL/5+tc/
8Ht7/wDHqAOgorn/APhDdL/5+tc/8Ht7/wDHqP8AhDdL/wCfrXP/AAe3v/x6gDoKK5//AIQ3S/8A
n61z/wAHt7/8eo/4Q3S/+frXP/B7e/8Ax6gDoKK5/wD4Q3S/+frXP/B7e/8Ax6j/AIQ3S/8An61z
/wAHt7/8eoA6Ciuf/wCEN0v/AJ+tc/8AB7e//HqP+EN0v/n61z/we3v/AMeoA6Ciuf8A+EN0v/n6
1z/we3v/AMeo/wCEN0v/AJ+tc/8AB7e//HqAOgorn/8AhDdL/wCfrXP/AAe3v/x6j/hDdL/5+tc/
8Ht7/wDHqAOgorl9DtBpnjLWLCC5vpLVdPsplS7vZrna7SXIYgysxGQi9PQV1FABRRRQBz/jv/kn
niX/ALBV1/6Kaugrn/Hf/JPPEv8A2Crr/wBFNXQUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFF
cd4f8MaBqNjd3V7oemXNw+p3++ae0jd2xdSgZJGTwAPwoA7GisP/AIQvwr/0LWjf+AEX/wATR/wh
fhX/AKFrRv8AwAi/+JoA3KKw/wDhC/Cv/QtaN/4ARf8AxNH/AAhfhX/oWtG/8AIv/iaANyisP/hC
/Cv/AELWjf8AgBF/8TR/whfhX/oWtG/8AIv/AImgDcorD/4Qvwr/ANC1o3/gBF/8TR/whfhX/oWt
G/8AACL/AOJoA3KKw/8AhC/Cv/QtaN/4ARf/ABNH/CF+Ff8AoWtG/wDACL/4mgDcorD/AOEL8K/9
C1o3/gBF/wDE1j23hLw23jPU4D4e0kwpp9o6xmyj2qzSXIJAxgEhVyfYelAHaUVh/wDCF+Ff+ha0
b/wAi/8AiaP+EL8K/wDQtaN/4ARf/E0AblFYf/CF+Ff+ha0b/wAAIv8A4mj/AIQvwr/0LWjf+AEX
/wATQBuUVh/8IX4V/wCha0b/AMAIv/iaP+EL8K/9C1o3/gBF/wDE0AblFYf/AAhfhX/oWtG/8AIv
/iaP+EL8K/8AQtaN/wCAEX/xNAG5RWH/AMIX4V/6FrRv/ACL/wCJo/4Qvwr/ANC1o3/gBF/8TQBu
UVh/8IX4V/6FrRv/AAAi/wDiax7nwl4bXxnpkA8PaSIX0+7doxZR7WZZLYAkYwSAzYPufWgDtKKw
/wDhC/Cv/QtaN/4ARf8AxNH/AAhfhX/oWtG/8AIv/iaANyisP/hC/Cv/AELWjf8AgBF/8TR/whfh
X/oWtG/8AIv/AImgDcorD/4Qvwr/ANC1o3/gBF/8TR/whfhX/oWtG/8AACL/AOJoA3KKw/8AhC/C
v/QtaN/4ARf/ABNH/CF+Ff8AoWtG/wDACL/4mgDcorD/AOEL8K/9C1o3/gBF/wDE0f8ACF+Ff+ha
0b/wAi/+JoA3KKw/+EL8K/8AQtaN/wCAEX/xNH/CF+Ff+ha0b/wAi/8AiaANyisP/hC/Cv8A0LWj
f+AEX/xNH/CF+Ff+ha0b/wAAIv8A4mgDcorD/wCEL8K/9C1o3/gBF/8AE0f8IX4V/wCha0b/AMAI
v/iaANyisP8A4Qvwr/0LWjf+AEX/AMTR/wAIX4V/6FrRv/ACL/4mgDcorD/4Qvwr/wBC1o3/AIAR
f/E0f8IX4V/6FrRv/ACL/wCJoA3KKw/+EL8K/wDQtaN/4ARf/E0f8IX4V/6FrRv/AAAi/wDiaANy
isP/AIQvwr/0LWjf+AEX/wATR/whfhX/AKFrRv8AwAi/+JoA3KKw/wDhC/Cv/QtaN/4ARf8AxNH/
AAhfhX/oWtG/8AIv/iaANyisP/hC/Cv/AELWjf8AgBF/8TR/whfhX/oWtG/8AIv/AImgDcorD/4Q
vwr/ANC1o3/gBF/8TR/whfhX/oWtG/8AACL/AOJoA3KKw/8AhC/Cv/QtaN/4ARf/ABNH/CF+Ff8A
oWtG/wDACL/4mgDcorD/AOEL8K/9C1o3/gBF/wDE0f8ACF+Ff+ha0b/wAi/+JoA3KKw/+EL8K/8A
QtaN/wCAEX/xNH/CF+Ff+ha0b/wAi/8AiaANyisPwX/yIvh7/sGW3/opa3KACiiigAooooAKKKKA
CiiigAooooAKKKKAOfs/+Sh6z/2CrD/0bd10Fc/Z/wDJQ9Z/7BVh/wCjbuugoAKKKKAOf8d/8k88
S/8AYKuv/RTV0Fc/47/5J54l/wCwVdf+imroKACiiigAooooAKKKKACiiigAooooAKKKKACsPwn/
AMge4/7Cd/8A+lc1blYfhP8A5A9x/wBhO/8A/SuagDcooooAw/GU81r4J1y4t5ZIZo7GZ0kjYqys
EOCCOQavS38On6G+oXbkQ29t50rdTtVck/pTdd0z+2tA1DS/O8n7ZbvB5m3ds3KRnGRnr0zVFdH1
W6sptO1fUNPutPmt2gkjgsXhcgrt+8ZmH6UAUNG8dWmqarBYF9NZ7pWaAWWopcuNo3YkUAbDjPTc
OCM9MrpHjC7v4dCurrSFtbTWPkgdbrzHR/LZwGXYBtIQ4IJPTIFaum6dq9q6pe6xHc28SbI0jtBG
7dgZGLNuIH90Jz+VU7Twr9l0nw3Y/bN/9iyI+/ysedtiePGM/L9/PfpigCt/wl940Vjepo6tpd9e
RW1vOLr95td9okdNvA9AGJPGcZ4ypdZ19oI5JYkMg8QfZ40guz+8TLgo2UUBRgeueTjPWKHT72Wb
S9GtDfx2NjqEcy28umtF5MUbFtrTklJF4G0Jz0znBrox4Yn+0ktfxm2XUxqMUYtyHU/NuUtvwQS3
BwMY70AXdG1efUJ760vbNLW8spFSRI5vNjYMoZWViqk8Huo5BrWrPs9M+yavqV/52/7aYzs242bF
29c8569q0KACsO1/5HrVv+wZZf8Ao26rcrDtf+R61b/sGWX/AKNuqANyiiigAooooA5bToD4nS7v
7q8v4lS8nt7eO2u3hEaxOY8kIRuJKlvmyOQMVHqL6jYan4PtJ9Rknke7kjuJEHlicCCQjcoOD0B9
MjIA6DRfRtQtridtH1OC0guZGllintPO2u33mjIddpPU5DDJzjqKjHhZEfQil7Kw0qeSctMN7zs6
OpJPGDlyeBjtgUAY/hnSG1jw/LfSapq0eoPdXapONQmKptnkVcRljGQAAMFccV0nhvUpdY8NadqM
6hZri3R5AvTdjnHtmsmw8Na1p2ny6bBrtrHZSSzOGSwInQSOznDmUrkFjglD06V0VjZQadYW9lao
Et7eNYo19FUYFAFiiiigArDuv+R60n/sGXv/AKNta3Kw7r/ketJ/7Bl7/wCjbWgDcooooAKKKKAC
iiigAooooAKKKKACiiigAooooAiuiVtJmUkERsQR24rzbRJvtXhjSLjTpfEsuuyW9u5kne9MDOQu
8sZT5JQ5bp2+72r0uaPzYJI843qVz6ZFVNE03+x9B0/TPN877HbRweZt279ihc4ycZx0zQBieI/F
s/h1Lm6nsbQWNtgs01+sc0qnHMcYU7upGGZSSDx0zU8T+J5YPD2vGOKSG706aAIsc2DMjuhRgeMB
ssv1B60/V/A82pR6zBFqVvbw6puaSQ2QedWKhceZvGUwOm3OONwqr4j8NP4g8U6fDA9xAttCDfTm
3IilCMrRKCcbjuLngnbzntkA0ZfF88dpcamumI2j2srQ3Fz9pxICjbJGWPbhkUg87gSAcDplfEXi
2fw7Hc3U9jaCxt8Fmmv1jmlU45jjCnd1IwzKSQeOmVuPCMstvdaZHqKx6LdzNNNa/Z90hLvvdVkL
YCMSeNpIycEcYrav4Hl1KLWLeHUbe3h1Tc0khsQ86sVC48zcMpgdNuccBhQBb1fX73Op2+l6f9pS
xg3XEv2jy3VmTcojXadzYIPJUcjk1raFI83h7TJZXZ5HtImZ2OSxKDJJ7ms288N3kk161hqotFv4
VjugbYSHcE2B4zuG1sYHO4cDgda2dOtPsGmWlnv8z7PCkW/GN21QM47dKALNFFFABRRRQAUUUUAF
FFFABRRRQAUUUUAFFFFAGH4L/wCRF8Pf9gy2/wDRS1uVh+C/+RF8Pf8AYMtv/RS1uUAFFFFABRRR
QAUUUUAFFFFABRRRQAUUUUAc/Z/8lD1n/sFWH/o27roK5+z/AOSh6z/2CrD/ANG3ddBQAUUUUAc/
47/5J54l/wCwVdf+imroK5/x3/yTzxL/ANgq6/8ARTV0FABRRRQAUUUUAFFFFABRRRQAUUUUAFFF
FABWH4T/AOQPcf8AYTv/AP0rmrcrkdDfxFb6fJ9k0vTZbaa7uriF7i/khdkknkkXKCBscMO5oA66
isP7V4q/6A2jf+DaX/5Go+1eKv8AoDaN/wCDaX/5GoA3KKw/tXir/oDaN/4Npf8A5Go+1eKv+gNo
3/g2l/8AkagDcorD+1eKv+gNo3/g2l/+RqPtXir/AKA2jf8Ag2l/+RqANyisP7V4q/6A2jf+DaX/
AORqPtXir/oDaN/4Npf/AJGoA3KKw/tXir/oDaN/4Npf/kaj7V4q/wCgNo3/AINpf/kagDcrDtf+
R61b/sGWX/o26o+1eKv+gNo3/g2l/wDkaqMUHiqLXbvU/wCy9GP2i2gt/L/tSX5fLaVs5+z8583p
jjb78AHVUVh/avFX/QG0b/wbS/8AyNR9q8Vf9AbRv/BtL/8AI1AG5RXKReIPEk2tT6YPD+nrJCgc
ytqUojboSqt9n5IDLn/e4zg4v/avFX/QG0b/AMG0v/yNQBuUVh/avFX/AEBtG/8ABtL/API1H2rx
V/0BtG/8G0v/AMjUAblFYf2rxV/0BtG/8G0v/wAjUfavFX/QG0b/AMG0v/yNQBuUVh/avFX/AEBt
G/8ABtL/API1H2rxV/0BtG/8G0v/AMjUAblYd1/yPWk/9gy9/wDRtrR9q8Vf9AbRv/BtL/8AI1UZ
YPFUuu2mp/2Xow+z209v5f8AakvzeY0TZz9n4x5XTHO725AOqorD+1eKv+gNo3/g2l/+RqPtXir/
AKA2jf8Ag2l/+RqANyisP7V4q/6A2jf+DaX/AORqPtXir/oDaN/4Npf/AJGoA3KKw/tXir/oDaN/
4Npf/kaoLrVfE9qYN+haUwllEW5NUlIQnOC3+j9MgD6kfWgDo6Kw/tXir/oDaN/4Npf/AJGo+1eK
v+gNo3/g2l/+RqANyisP7V4q/wCgNo3/AINpf/kaj7V4q/6A2jf+DaX/AORqANyisP7V4q/6A2jf
+DaX/wCRqPtXir/oDaN/4Npf/kagDcorD+1eKv8AoDaN/wCDaX/5Go+1eKv+gNo3/g2l/wDkagDc
orD+1eKv+gNo3/g2l/8Akaj7V4q/6A2jf+DaX/5GoA3KKw/tXir/AKA2jf8Ag2l/+RqPtXir/oDa
N/4Npf8A5GoA3KKw/tXir/oDaN/4Npf/AJGo+1eKv+gNo3/g2l/+RqANyiueutR8VWtpNcf2DpUv
lRs/lxarIXfAzhR9n5J7U+O98USRrIujaPtYAj/iayjg/wDbtQBvUVh/avFX/QG0b/wbS/8AyNR9
q8Vf9AbRv/BtL/8AI1AG5RWH9q8Vf9AbRv8AwbS//I1H2rxV/wBAbRv/AAbS/wDyNQBuUVh/avFX
/QG0b/wbS/8AyNR9q8Vf9AbRv/BtL/8AI1AG5RWH9q8Vf9AbRv8AwbS//I1H2rxV/wBAbRv/AAbS
/wDyNQBuUVh/avFX/QG0b/wbS/8AyNR9q8Vf9AbRv/BtL/8AI1AG5RWH9q8Vf9AbRv8AwbS//I1H
2rxV/wBAbRv/AAbS/wDyNQBuUVh/avFX/QG0b/wbS/8AyNR9q8Vf9AbRv/BtL/8AI1AB4L/5EXw9
/wBgy2/9FLW5WN4Tie28K6bYyqVmsoEs5QQQC8Q2MRnqpK5B7gg1s0AFFFFABRRRQAUUUUAFFFFA
BRRRQAUUUUAc/Z/8lD1n/sFWH/o27roK5+z/AOSh6z/2CrD/ANG3ddBQAUUUUAc/47/5J54l/wCw
Vdf+imroK5/x3/yTzxL/ANgq6/8ARTV0FABRRRQAUUUUAFFFFABRRRQAUUUUAFFFISACSQAOpNAF
HU1e4SOxVZttySkssL7TEmCSc++AvHPzdsVfrN02MXEsuqSRIss48uJ0k3hoFZijdcfMG3ceoz0r
SoAKKKKACiiigAooooAKKKKACiiigAooooAKr31xLa2UssFu1xMB+7hU4Lt2Ge3uew5qxWbsTUNX
DvFDJDYkNDIH3ETkMrjA6EKw68/OaAGzafJbaREkEtzcXFp++jLSgNO4ydrHGMNkjpgZ4AwK0o3E
sSuAQGAOGGCPY06s2zRdPv5bFY4oraTM8H7zLO7MzSjaegBIPHHze1AGlRRRQAUUUUAFFFFABRRR
QAUUUUAFFFFABUN5bLeWU9q7yIs0bRlonKsoIxkEcg+9TUUAVbCaWa2InheKWN2jIcglgpIDcdmG
D+NWqzbkJYaml9tRY7kLBcyvLtC4J8sgE4yWbbxydy9hWlQAUUUUAFFFFABRRRQAUUUUAFFFFABR
RRQAVQsFe2nuLJlnaNWMsc0r7twdmJUd/lPGOwK81fqhqdu7LDd28Cy3dq26IM23Knhx1A5XOM8Z
APagC/RUcE0VzBHPBIskMih0dDkMpGQQe4qSgAooooAKKKKACiiigAooooAKKKKACiiigCgyvbau
JVEzxXShH+f5ImXJBxj+LOCc/wAK8c1fqve2cN/aPbTpuRiDjJGCCGUgjoQQD+FN065kubJGuBEt
0oCXCRPuVJAOQD/jzgigC1RRRQAUUUUAFFFFABRRRQAUUUUAFFFFAHP2f/JQ9Z/7BVh/6Nu66Cuf
s/8Akoes/wDYKsP/AEbd10FABRRRQBz/AI7/AOSeeJf+wVdf+imroK5/x3/yTzxL/wBgq6/9FNXQ
UAFFFFABRRRQAUUUUAFFFFABRRRQAVnalL500GmRSRCW4y8iSKWzApAk9udwXnH3ie1aNZ+lu12k
moGSQxXJDQRyRbDHHtAx6nJy3OPvAY4oAvqqogVQAqjAA6AUtFFABRRRQAUUUUAFFFFABRRRQAUU
UUAFFFFAFTUbsWdmXDKJXZYoQwJBkY7VBwCcZIyccDJ6Cn2VqtparEAgYkvIyLtDuxyzY9ySfxqt
E7Xmsysskyw2QMLRNEAkkjBGDBjydoOOOMs3UjjRoAKp6jbyzwpJbCH7VC4khaVcgHow45GVLLkd
M1cooAgs7uG/s4bu2ffDMgdGwRkH2PI+hqes+3c2uqS2bvK4uA1xD+7wkajYrJuHfJ3c/wB49cVo
UAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUARzwRXMDwzIrxuMMrDINVtMuXnt2huJopL22IiujECF
8zaG4B6Ahgfxq7WfdO9pqNvcb5DBN+4eJIwRvJG1yc5AGCvf7w6YoA0KKKKACiiigAooooAKKKKA
CiiigAooooAKKKKAM2wZbO9m0xmhUY821ijQriH5QQe2Q5PTsy1pVR1QSR2v2uFpA9t+9KxRh2lQ
ctGASOWAwOeuD2q5HIssSSIcq6hgfY0AOooooAKKKKACiiigAooooAKKKKACiiigArMlYafq0chM
MdtenY+EO9rjACEkDGCqkZPcKB1rTqG6gNzaSwiRomdSFkUDKHswz3B5FAE1FVdPuvtdpuYSCSN2
ik3psJZGKk4yeDjI56EVaoAKKKKACiiigAooooAKKKKACiiigDn7P/koes/9gqw/9G3ddBXP2f8A
yUPWf+wVYf8Ao27roKACiiigDn/Hf/JPPEv/AGCrr/0U1dBXP+O/+SeeJf8AsFXX/opq6CgAoooo
AKKKKACiiigAooooAKKKKAKGqK1ykdgqz7blisskL7DEgBJOffAXjn5u2Kv1yljrdzPe399F4Y1G
4bz5LMTwTW+10hldBgPMpHzb/wCEde/Wr/8Abuo/9CnrP/f2z/8Aj9AG5RWH/buo/wDQp6z/AN/b
P/4/R/buo/8AQp6z/wB/bP8A+P0AblFYf9u6j/0Kes/9/bP/AOP0f27qP/Qp6z/39s//AI/QBuUV
h/27qP8A0Kes/wDf2z/+P0f27qP/AEKes/8Af2z/APj9AG5RWH/buo/9CnrP/f2z/wDj9H9u6j/0
Kes/9/bP/wCP0AblFYf9u6j/ANCnrP8A39s//j9H9u6j/wBCnrP/AH9s/wD4/QBuUVh/27qP/Qp6
z/39s/8A4/R/buo/9CnrP/f2z/8Aj9AG5Ve9uHtbR5YoGnl4EcSnBdj2z2HcnsATWX/buo/9CnrP
/f2z/wDj9Q2N+2s+IpIL3R57J9NhiuYRcvGz7pfNTcPLdl6Iw5OeT+IBt2VqLKzitxLJLsHMkpyz
nqSfcnJ44qeiigAooooApapDJJZ+bCJGnt28+JI32eYy5+QnB4b7p471aikEsSyAEBhnB6j2PvT6
5s6pLpWuXmk2OhXV5EsSXhNpJENrSvLuyJZF6sjH5c9TnHcA6SisP+3dR/6FPWf+/tn/APH6P7d1
H/oU9Z/7+2f/AMfoA3KKw/7d1H/oU9Z/7+2f/wAfo/t3Uf8AoU9Z/wC/tn/8foA3KKw/7d1H/oU9
Z/7+2f8A8fo/t3Uf+hT1n/v7Z/8Ax+gDcorD/t3Uf+hT1n/v7Z//AB+j+3dR/wChT1n/AL+2f/x+
gDcorD/t3Uf+hT1n/v7Z/wDx+j+3dR/6FPWf+/tn/wDH6ANyisP+3dR/6FPWf+/tn/8AH6P7d1H/
AKFPWf8Av7Z//H6ANyormBLq1mt5CwSVCjFG2kAjHBHQ1kf27qP/AEKes/8Af2z/APj9H9u6j/0K
es/9/bP/AOP0AaOnTSy2u2aOSOWJ2iPmEFnCkgPkcfMAG/GrdcvHq00fiWyMvh2+sW1Im1ee4kgI
JSOSVBiOVucK/OO/WuooAKzdburq2sAtkUW6uJUgidxlULHBYjvgZOO+MVpVR1WwbUbLyopjBOjr
LDLjOx1ORkdxxgjuCaAKI8MxAeZ/amrfbMf8fH26Trjr5efL/DZj2q3ot5PeWLC72fa7eVoJinCs
ynG4DsCMNjtnFVvt2vGIxDRoRdYx5v2oGDPrnG/3xt9s96u6XYf2dZCFpWmlZmkllYYLuxyxx2GT
wOwwO1AEet3s1hpjSWqK1zJJHBCGGVDu4QMenA3ZPsDVQeGYivmSapqzXeObgX0i8+ojB8vHttx7
Vf1XTxqenyW3mGJ9yyRygZKSKwZWx3wwHHfpVIX+vLH5TaLE9zyPNW7UQH3JI3j6bT9T1oAn0S8n
ubaeC7dHu7OZred04DEAMrY7EqysR2JqXWb6TTtJnuYUV5htSJXOFMjMFXJ9NzDNGk2D6fZlJ5hN
cyyNNPKFwGdjzgdgBgAegFP1KxXUtOns2keLzF+WSPG6NgcqwzxkEA8+lAGcnhqNwst1qWqS3gAz
Ol7JEufURqwQD22n3zVjRLm5kS7s7xzLc2U/ktNtC+cpVXV8DjO1gD0+YHAAxUK3uuwxCGXSI7i4
Ax58VwqQsfU5+dc9cANj1NWdG0+axt5Xu5UlvbqUz3EiAhSxAUBQewVVUfTPegDRooooAKz7BTaX
VzZbJzHkzxyyybw29mLKO42nt2DLj0GhWR4ilj0/S5daMPmSaZG9yBuIygU7xwRnK5wDxnB7UAa9
FYf9u6j/ANCnrP8A39s//j9H9u6j/wBCnrP/AH9s/wD4/QBuUVh/27qP/Qp6z/39s/8A4/R/buo/
9CnrP/f2z/8Aj9AG5RWH/buo/wDQp6z/AN/bP/4/R/buo/8AQp6z/wB/bP8A+P0AblFYf9u6j/0K
es/9/bP/AOP0f27qP/Qp6z/39s//AI/QBuUVh/27qP8A0Kes/wDf2z/+P0f27qP/AEKes/8Af2z/
APj9AG5RWH/buo/9CnrP/f2z/wDj9H9u6j/0Kes/9/bP/wCP0AblFYf9u6j/ANCnrP8A39s//j9H
9u6j/wBCnrP/AH9s/wD4/QBcdWtdWWZRM8d2Fif5vkiZQxDY7bs7Sc9QvHNaFc7d6ld31s9vceEN
ZeNsEjzrQYIIIIPn8EEAg+1X/D+qS6xosN5PbNbXG6SKeEkHZLG7RuAQSCNynHJ4xQBp0UUUAFFF
FABRRRQAUUUUAFFFFAHP2f8AyUPWf+wVYf8Ao27roK5+z/5KHrP/AGCrD/0bd10FABRRRQBz/jv/
AJJ54l/7BV1/6Kaugrn/AB3/AMk88S/9gq6/9FNXQUAFFFFABRRRQAUUUUAFFFFABRRRQBh+E/8A
kD3H/YTv/wD0rmrcrD8J/wDIHuP+wnf/APpXNW5QAUUUUAVYtQtZtRuNPjlzdWyJJLHtPyq+7ac4
wc7W6elKL+2bUn08Sf6UkKztHtPCElQc9OqnjrxWFpn/ACUXxF/15WP856ki/wCSkXX/AGCIf/R0
tAGzNqFrb39rYyy7bm6V2hTaTuCY3c4wMZHWsm38Z6JdJHLHLeLbyfduJdPuI4fr5jIEA9ycVBq/
/I++Gf8Arje/+gx1R0Ka2g+Els94V+z/ANnsHDchgQRjHcnpjvQB2lQ3d3b2FnNd3cyQ28Kl5JHO
AoHc1yJsbkabpUd7pPiC8uo7CFJpdP1T7NHvC/MCv2iP5s5529xzxxf1Kwt5PBVyZrK6iaC0naOK
+n8+WM7W5Zt7hj6HccA9ulAGtdazYWdhDezTN5M+0Q7Ind5CwyAqKCxOMnAGeKl0/UbXVLb7RaSF
0DFGDIyMrDqrKwBUj0IBrnCwjm8FSOQI8FMnpvNu23n1OGFW/DgY6z4nkU5gbUl2EHIyLeINj/gQ
I+oNAHRUUUUAFYdr/wAj1q3/AGDLL/0bdVuVh2v/ACPWrf8AYMsv/Rt1QBuUUUUAFFFFABWHa/8A
I9at/wBgyy/9G3VblYdr/wAj1q3/AGDLL/0bdUAblFFFABVa6v7aye2S4k2NczCCIbSdzkEgcdOF
PJ44qzXO+Kf+Pvw3/wBhdP8A0VLQBsX2oWumxRSXcvlpLNHAh2k5d2CqOB3JAz0pdQ1C10qwmvr2
XyraFd0j7S2B9ACawvG//IM0z/sMWP8A6PSj4hf8iFrH/XH/ANmFAF+88TaZY6jJYSG8luokWSSO
2sJ59itnaSY0YDO0/lV6xv7XUrVbmznWaEkruXsQcEEdQQRgg8isLTP+Si+Iv+vKx/nPVG1VbyTx
JPb21/eWcuop5Sadd+Q7MsSLIyv5icbgQfm5IPBoA6+5uYbO2lubiVYoYlLu7HAUDqTVPTNd0/V3
kS0kmEkah2jnt5IH2nowWRVJU4PIGOK5TU4Db+GNUk/s3WbFVELyNqeofaVMayKXwPPk2/KDk8Vs
yqLjx7b+W4aH+yZhNtb+9JHs6ewfB+tAGzbajZ3l3dWtvcJLNaMFnVefLYjIB98dqtVzXh+2htPE
3iGC3iWOJGtgqqMAfuq6WgAooooAw9d/5DHhj/sJv/6SXFblYeu/8hjwx/2E3/8ASS4rcoAKKKKA
CiiigAooooAKKKKACiiigAooooAKw/Gn/Ii+If8AsGXP/opq3Kw/Gn/Ii+If+wZc/wDopqANyiii
gAooooAq2GoWuqWn2qzl82He8e7aV+ZGKMMEA8MpH4Utnf21+kr2snmLFM8DnaRh0OGHPoR16Vhe
Af8AkVR/1+3n/pTLUng//j01X/sL3n/o1qAL134i0uyS/ae5YCwaNLkLC7lGkxsAABLE7h0z1osv
EOn390LaM3UU7AlEu7Oa3L467fMVd2O+M4ri9b/1/jL/AK/9M/nDXT+KT5kmi28LL9sbUoZIxjLB
VJMh9hs3DPvjvQB0NZV94k0rTbpre6uHV0AMrLBI6Qg9PMdVKpn/AGiKw7my3X8zf2B4rfMrHzIt
b2Rtz1VftYwvoNowOw6VVmMUWmfEJLwqN0sjENxuRrSML9ckED3BoA7G/wBSs9Lt1nvbhII2kWJS
38TscKAO5JNWq4vxjYxjwjbXM8IN5HLYxeY3LKPtMWQPTnr6/hXaUAFFFFABWH4T/wCQPcf9hO//
APSuatysPwn/AMge4/7Cd/8A+lc1AG5RRRQAUUUUAFFFFABRRRQAUUUUAc/Z/wDJQ9Z/7BVh/wCj
buugrn7P/koes/8AYKsP/Rt3XQUAFFFFAHP+O/8AknniX/sFXX/opq6Cuf8AHf8AyTzxL/2Crr/0
U1dBQAUUUUAFFFFABRRRQAUUUUAFFFFAGH4T/wCQPcf9hO//APSuatysPwn/AMge4/7Cd/8A+lc1
blABRRRQBmX3h3Q9UuPtGoaNp13PtC+ZcWqSNgdBkgnFNuPC/h+6WFbjQtMmWCMRRCS0jYRoOirk
cDk8CtWigCpb6Vp1otuttYWsK2wYQCOFVEQb7wXA+XPfHWqlt4X8P2d0l1a6FpkFwh3LNFaRq6n1
BAyK1qKACmyRpNE8UqK8bqVZGGQwPUEdxTqKAK1zp1jeWX2K6s7ee1wB5EsSsmB0+UjHFPtbS2sb
ZLa0t4reBBhIokCKo9gOBU1FABRRRQAVh2v/ACPWrf8AYMsv/Rt1W5WHa/8AI9at/wBgyy/9G3VA
G5RRRQAUUUUAFYdr/wAj1q3/AGDLL/0bdVuVh2v/ACPWrf8AYMsv/Rt1QBuUUUUAFVb/AE2w1W3F
vqNlbXkIYOI7iJZFDeuGBGeT+dWqKAMqPwv4fitZrWPQtMS2mKmWFbSMI5XoWGMHGeM0tv4a0G0i
nittE02GOdQsyR2qKJAOgYAcj61qUUAZl94d0PVLj7RqGjaddz7QvmXFqkjYHQZIJxWhFFHBEsUM
axxqMKiDAA9gKfRQAjKroyOoZWGCpGQRVTT9I03SY3j03T7SyRzl1toVjDH1IUDNXKKAI0ghjmlm
SKNZZceY6qAXwMDJ74FSUUUAFFFFAGHrv/IY8Mf9hN//AEkuK3Kw9d/5DHhj/sJv/wCklxW5QAUU
UUAFFFFABRRRQAUUUUAFFFFABRRRQAVh+NP+RF8Q/wDYMuf/AEU1blYfjT/kRfEP/YMuf/RTUAbl
FFFABRRRQBkf8Ip4c+1fav7A0r7Rv8zzfsce/dnO7OM5zzmibwp4cubl7mfQNKlnkYu8r2cbMzHk
kkjJPvWvRQBUn0rTrqO5juLC1mS62m4WSFWEu3G3eCPmxgYz0xUen6HpGkO76bpVjZNIAHa2t0jL
AdM7QM1fooAKpXOj6Ze3kV3dabZz3MP+rmlgVnT6MRkVdooAiuLaC7i8q5hjmj3K2yRAwyCCDg9w
QCPcVLRRQAUUUUAFYfhP/kD3H/YTv/8A0rmrcrD8J/8AIHuP+wnf/wDpXNQBuUUUUAFFFFABRRRQ
AUUUUAFFFFAHP2f/ACUPWf8AsFWH/o27roK5+z/5KHrP/YKsP/Rt3XQUAFFFFAHP+O/+SeeJf+wV
df8Aopq6Cub+IM8Nt8OfEjzyxxIdMuEDOwUFmjKqOe5YgAdyQKk/4Tvwf/0Neh/+DGH/AOKoA6Ci
uf8A+E78H/8AQ16H/wCDGH/4qj/hO/B//Q16H/4MYf8A4qgDoKK5/wD4Tvwf/wBDXof/AIMYf/iq
P+E78H/9DXof/gxh/wDiqAOgorn/APhO/B//AENeh/8Agxh/+Ko/4Tvwf/0Neh/+DGH/AOKoA6Ci
uf8A+E78H/8AQ16H/wCDGH/4qj/hO/B//Q16H/4MYf8A4qgDoKK5/wD4Tvwf/wBDXof/AIMYf/iq
P+E78H/9DXof/gxh/wDiqAJD4S0vzJXR9Ti82V5mSHVbqNN7sWYhVkAGWJPA70f8Inp3/PzrP/g6
vP8A47Uf/Cd+D/8Aoa9D/wDBjD/8VR/wnfg//oa9D/8ABjD/APFUASf8Inp3/PzrP/g6vP8A47R/
wienf8/Os/8Ag6vP/jtR/wDCd+D/APoa9D/8GMP/AMVR/wAJ34P/AOhr0P8A8GMP/wAVQBJ/wien
f8/Os/8Ag6vP/jtH/CJ6d/z86z/4Orz/AOO1H/wnfg//AKGvQ/8AwYw//FUf8J34P/6GvQ//AAYw
/wDxVAEn/CJ6d/z86z/4Orz/AOO0f8Inp3/PzrP/AIOrz/47Uf8Awnfg/wD6GvQ//BjD/wDFUf8A
Cd+D/wDoa9D/APBjD/8AFUASf8Inp3/PzrP/AIOrz/47R/wienf8/Os/+Dq8/wDjtR/8J34P/wCh
r0P/AMGMP/xVH/Cd+D/+hr0P/wAGMP8A8VQBJ/wienf8/Os/+Dq8/wDjtH/CJ6d/z86z/wCDq8/+
O1H/AMJ34P8A+hr0P/wYw/8AxVH/AAnfg/8A6GvQ/wDwYw//ABVAEn/CJ6d/z86z/wCDq8/+O0f8
Inp3/PzrP/g6vP8A47Uf/Cd+D/8Aoa9D/wDBjD/8VR/wnfg//oa9D/8ABjD/APFUASf8Inp3/Pzr
P/g6vP8A47VvTdDsdJnnntvtLTTqiSSXF3LOxVCxUZkZiAC7cD1qh/wnfg//AKGvQ/8AwYw//FUf
8J34P/6GvQ//AAYw/wDxVAHQUVz/APwnfg//AKGvQ/8AwYw//FUf8J34P/6GvQ//AAYw/wDxVAHQ
UVz/APwnfg//AKGvQ/8AwYw//FUf8J34P/6GvQ//AAYw/wDxVAHQVlX3h3T9RvzezG8juDEsLPbX
09vuRSxUERuoOC7dfU1U/wCE78H/APQ16H/4MYf/AIqj/hO/B/8A0Neh/wDgxh/+KoAk/wCET07/
AJ+dZ/8AB1ef/HaP+ET07/n51n/wdXn/AMdqP/hO/B//AENeh/8Agxh/+Ko/4Tvwf/0Neh/+DGH/
AOKoAk/4RPTv+fnWf/B1ef8Ax2j/AIRPTv8An51n/wAHV5/8dqP/AITvwf8A9DXof/gxh/8AiqP+
E78H/wDQ16H/AODGH/4qgCT/AIRPTv8An51n/wAHV5/8do/4RPTv+fnWf/B1ef8Ax2o/+E78H/8A
Q16H/wCDGH/4qj/hO/B//Q16H/4MYf8A4qgCT/hE9O/5+dZ/8HV5/wDHaP8AhE9O/wCfnWf/AAdX
n/x2o/8AhO/B/wD0Neh/+DGH/wCKo/4Tvwf/ANDXof8A4MYf/iqAJP8AhE9O/wCfnWf/AAdXn/x2
j/hE9O/5+dZ/8HV5/wDHaj/4Tvwf/wBDXof/AIMYf/iqP+E78H/9DXof/gxh/wDiqAJP+ET07/n5
1n/wdXn/AMdo/wCET07/AJ+dZ/8AB1ef/Haj/wCE78H/APQ16H/4MYf/AIqj/hO/B/8A0Neh/wDg
xh/+KoAk/wCET07/AJ+dZ/8AB1ef/HaP+ET07/n51n/wdXn/AMdqP/hO/B//AENeh/8Agxh/+Ko/
4Tvwf/0Neh/+DGH/AOKoAsW/hjTba9t7wNfyzW7F4vtGpXEyoxVkJ2u5XO1mGcd62K5//hO/B/8A
0Neh/wDgxh/+Ko/4Tvwf/wBDXof/AIMYf/iqAOgorn/+E78H/wDQ16H/AODGH/4qj/hO/B//AENe
h/8Agxh/+KoA6Ciuf/4Tvwf/ANDXof8A4MYf/iqP+E78H/8AQ16H/wCDGH/4qgDoKK5//hO/B/8A
0Neh/wDgxh/+Ko/4Tvwf/wBDXof/AIMYf/iqAOgorn/+E78H/wDQ16H/AODGH/4qj/hO/B//AENe
h/8Agxh/+KoA6Ciuf/4Tvwf/ANDXof8A4MYf/iqP+E78H/8AQ16H/wCDGH/4qgDoKK5//hO/B/8A
0Neh/wDgxh/+Ko/4Tvwf/wBDXof/AIMYf/iqAOgqC9s4NRsLiyuo/Mt7iJoZUyRuRhgjI5HBPSsb
/hO/B/8A0Neh/wDgxh/+Ko/4Tvwf/wBDXof/AIMYf/iqAJP+ET07/n51n/wdXn/x2j/hE9O/5+dZ
/wDB1ef/AB2o/wDhO/B//Q16H/4MYf8A4qj/AITvwf8A9DXof/gxh/8AiqAJP+ET07/n51n/AMHV
5/8AHaP+ET07/n51n/wdXn/x2o/+E78H/wDQ16H/AODGH/4qj/hO/B//AENeh/8Agxh/+KoAk/4R
PTv+fnWf/B1ef/HaP+ET07/n51n/AMHV5/8AHaj/AOE78H/9DXof/gxh/wDiqP8AhO/B/wD0Neh/
+DGH/wCKoAk/4RPTv+fnWf8AwdXn/wAdo/4RPTv+fnWf/B1ef/Haj/4Tvwf/ANDXof8A4MYf/iqP
+E78H/8AQ16H/wCDGH/4qgCT/hE9O/5+dZ/8HV5/8do/4RPTv+fnWf8AwdXn/wAdqP8A4Tvwf/0N
eh/+DGH/AOKo/wCE78H/APQ16H/4MYf/AIqgCT/hE9O/5+dZ/wDB1ef/AB2j/hE9O/5+dZ/8HV5/
8dqP/hO/B/8A0Neh/wDgxh/+Ko/4Tvwf/wBDXof/AIMYf/iqAJP+ET07/n51n/wdXn/x2j/hE9O/
5+dZ/wDB1ef/AB2o/wDhO/B//Q16H/4MYf8A4qj/AITvwf8A9DXof/gxh/8AiqAJP+ET07/n51n/
AMHV5/8AHa0tO0610myWzs1dYVZ3/eStIxZ2LsSzEsSWYnJPesn/AITvwf8A9DXof/gxh/8AiqP+
E78H/wDQ16H/AODGH/4qgDoKK5//AITvwf8A9DXof/gxh/8AiqP+E78H/wDQ16H/AODGH/4qgDoK
K5//AITvwf8A9DXof/gxh/8AiqP+E78H/wDQ16H/AODGH/4qgDoKK5//AITvwf8A9DXof/gxh/8A
iqP+E78H/wDQ16H/AODGH/4qgDoKK5//AITvwf8A9DXof/gxh/8AiqP+E78H/wDQ16H/AODGH/4q
gDoKK5//AITvwf8A9DXof/gxh/8AiqP+E78H/wDQ16H/AODGH/4qgAs/+Sh6z/2CrD/0bd10Fcno
OrabrPjrW7jS9QtL6BdMsUaS1mWVQ3m3ZwSpIzgg49xXWUAFFFFABRRRQAUUUUAFFFFABRRRQAUU
UUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRR
QAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFA
BRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFAEYghW4e4WKMT
uio8gUbmVSSoJ6kAsxA7bj61JRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQ
AUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFAB
RRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFF
FFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQB//Z
------=_Part_4871_2577433.1145249483911--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
