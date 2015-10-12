Return-Path: <cyrus@holtmann.org>
Subject: Re: fd from NewConnection always zero
To: <linux-bluetooth@vger.kernel.org>
References: <56174EAC.5040201@netcommwireless.com>
From: Alan Au <alan.au@netcommwireless.com>
Message-ID: <561B4B68.9070001@netcommwireless.com>
Date: Mon, 12 Oct 2015 16:55:52 +1100
MIME-Version: 1.0
In-Reply-To: <56174EAC.5040201@netcommwireless.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



On 09/10/15 16:20, Alan Au wrote:
> Hi,
>
> I'm trying to connect to an SPP profile with Device1.ConnectProfile. I 
> have registered my side of the Profile (client role) with 
> ProfileManager1.RegisterProfile. That all works fine and my 
> NewConnection callback is invoked.
>
> However, NewConnection is always getting an fd with value 0. I know 
> the socket is actually correctly set up because I can see it in 
> /proc/<pid>/fd and the remote device also shows the connection 
> established. And if I hard code the fd to what is shown in 
> /proc/<pid>/fd (it usually doesn't change between runs) I can 
> successfully use it in a read call to get what the other end is sending.

Just FYI and for anyone future readers of this thread. I worked out my 
problem. It was my misunderstanding of how glib returns the fd. The fd 
value in the NewConnection parameter list is not the actual fd but 
rather an index into the GDBusMessage fd_list. So need to get the 
message with g_dbus_method_invocation_get_message, then get the fdlist 
with g_dbus_message_get_unix_fd_list and finally get the actual fd from 
the list with one of the g_unix_fd_list_ APIs.

Alan

>
> Any ideas what I might be doing wrong? I'm on 5.33.
>
> Below is a simplified version of my NewConnection handler. The debug 
> statement prints out:
>
> device = /org/bluez/hci0/dev_18_E2_C2_71_1B_5F, fd = 0
>
> static void
> profile_handle_new_connection (GDBusConnection       *connection,
>                           const gchar           *sender,
>                           const gchar           *object_path,
>                           const gchar           *interface_name,
>                           const gchar           *method_name,
>                           GVariant              *parameters,
>                           GDBusMethodInvocation *invocation,
>                           gpointer               user_data)
> {
>     gint32 fd = -1;
>     char *device = "";
>
>     g_variant_get(parameters, "(&oh*)", &device, &fd, NULL);
>     dbg("device = %s, fd = %d\n", device, fd);
>
>     g_dbus_method_invocation_return_value(invocation, NULL);
> }
>
> Thanks!
>
> Alan


______________________________________________________________________
This communication contains information which may be confidential or privileged. The information is intended solely for the use of the individual or entity named above.  If you are not the intended recipient, be aware that any disclosure, copying, distribution or use of the contents of this information is prohibited.  If you have received this communication in error, please notify me by telephone immediately.
______________________________________________________________________
