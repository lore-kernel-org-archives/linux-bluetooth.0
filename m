Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Mauro Tortonesi <mtortonesi@ing.unife.it>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] l2cap xfer fails
References: <200401281135.58062.mtortonesi@ing.unife.it> <200401281200.07012.mtortonesi@ing.unife.it>
In-Reply-To: <200401281200.07012.mtortonesi@ing.unife.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200401281217.47133.mtortonesi@ing.unife.it>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 28 Jan 2004 12:17:47 +0100

On Wednesday 28 January 2004 12:00, Mauro Tortonesi wrote:
> On Wednesday 28 January 2004 11:35, Mauro Tortonesi wrote:
> > i've been testing bluetooth support for nc6. unfortunately, i couldn't
> > transfer data. both kernels are 2.4.25-pre7.
>
> sorry, my kmail client sucks. it keeps crashing and sending unfinished
> emails instead of postponining them. good old pine was not so bad :-(
>
> what i wanted to say is that i can transfer (over L2CAP) data from console,
> but transfer of files redirected to stdin always fails. perhaps i am doing
> something wrong? such as calling write(2) over L2CAP sockets with buffers
> larger that 762 bytes?

s/762/672/

ok, it seems that the problem was really that the size of the buffers i was 
passing to write(2) is too big. with this code:

#define IMTU 672

static ssize_t btwrite(int fd, const char *buf, size_t count)
{
        ssize_t res, pos = 0;

        while (count > pos) {
                res = send(fd, buf + pos, MIN(IMTU, count - pos), 0);
                switch (res) {
                case -1:
                        if (errno == EINTR || errno == EAGAIN)
                        continue;
                case 0:
                        return (res);
                default:
                        pos += res;
                }
        }
        return (pos);
}

i can finally use a write(2)-compatible api for writing on L2CAP sockets.

-- 
Aequam memento rebus in arduis servare mentem...

Mauro Tortonesi                 mtortonesi@ing.unife.it
                                mauro@deepspace6.net
                                mauro@ferrara.linux.it
Deep Space 6 - IPv6 with Linux  http://www.deepspace6.net
Ferrara Linux User Group        http://www.ferrara.linux.it





-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
