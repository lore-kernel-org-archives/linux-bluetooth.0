Return-Path: <cyrus@holtmann.org>
To: <linux-bluetooth@vger.kernel.org>
From: Alan Au <alan.au@netcommwireless.com>
Subject: fd from NewConnection always zero
Message-ID: <56174EAC.5040201@netcommwireless.com>
Date: Fri, 9 Oct 2015 16:20:44 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm trying to connect to an SPP profile with Device1.ConnectProfile. I 
have registered my side of the Profile (client role) with 
ProfileManager1.RegisterProfile. That all works fine and my 
NewConnection callback is invoked.

However, NewConnection is always getting an fd with value 0. I know the 
socket is actually correctly set up because I can see it in 
/proc/<pid>/fd and the remote device also shows the connection 
established. And if I hard code the fd to what is shown in 
/proc/<pid>/fd (it usually doesn't change between runs) I can 
successfully use it in a read call to get what the other end is sending.

Any ideas what I might be doing wrong? I'm on 5.33.

Below is a simplified version of my NewConnection handler. The debug 
statement prints out:

device = /org/bluez/hci0/dev_18_E2_C2_71_1B_5F, fd = 0

static void
profile_handle_new_connection (GDBusConnection       *connection,
                           const gchar           *sender,
                           const gchar           *object_path,
                           const gchar           *interface_name,
                           const gchar           *method_name,
                           GVariant              *parameters,
                           GDBusMethodInvocation *invocation,
                           gpointer               user_data)
{
     gint32 fd = -1;
     char *device = "";

     g_variant_get(parameters, "(&oh*)", &device, &fd, NULL);
     dbg("device = %s, fd = %d\n", device, fd);

     g_dbus_method_invocation_return_value(invocation, NULL);
}

Thanks!

Alan

______________________________________________________________________
This communication contains information which may be confidential or privileged. The information is intended solely for the use of the individual or entity named above.  If you are not the intended recipient, be aware that any disclosure, copying, distribution or use of the contents of this information is prohibited.  If you have received this communication in error, please notify me by telephone immediately.
______________________________________________________________________
