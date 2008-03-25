Return-Path: <cyrus@holtmann.org>
Message-ID: <e1effdeb0803251302p7df8a96di186a11bf316ba44a@mail.gmail.com>
Date: Tue, 25 Mar 2008 17:02:51 -0300
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1e9e22610803240814r3b0a9f05g603b485c8b1bb0ec@mail.gmail.com>
MIME-Version: 1.0
References: <1e9e22610803240814r3b0a9f05g603b485c8b1bb0ec@mail.gmail.com>
Subject: Re: [Bluez-users] hci_conn_info definition
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Mon, Mar 24, 2008 at 12:14 PM, Addo Del Grossi
<addo.delgrossi@gmail.com> wrote:
> Hi Guys,
>
>     I am using the struct hci_conn_info.
>     What is the definition the attributes handle and state?
>     What are the possible values for the attribute state?
>
>     struct hci_conn_info {
>         __u16    handle;
>          bdaddr_t bdaddr;
>         __u8     type;
>         __u8     out;
>         __u16    state;
>         __u32    link_mode;
>     };
>
>
> Att,
> Addo
>
> -------------------------------------------------------------------------
>  This SF.net email is sponsored by: Microsoft
>  Defy all challenges. Microsoft(R) Visual Studio 2008.
>  http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
>  Bluez-users mailing list
>  Bluez-users@lists.sourceforge.net
>  https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>


Hi Addo,

Connection handle identifies a logical channel between the host and controller.
Possible state values are:

/* Connection and socket states */
enum {
        BT_CONNECTED = 1, /* Equal to TCP_ESTABLISHED to make net code happy */
        BT_OPEN,
        BT_BOUND,
        BT_LISTEN,
        BT_CONNECT,
        BT_CONNECT2,
        BT_CONFIG,
        BT_DISCONN,
        BT_CLOSED
};

-- 
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
