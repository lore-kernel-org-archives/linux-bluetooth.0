Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1522077832.2966.4.camel@intel.com>
References: <20180324023336.13879-1-inga.stotland@intel.com>
 <CABBYNZKSyN0KZAray2afZXyESF1BeY0LOvK0hv-AuX05vu7MSg@mail.gmail.com> <1522077832.2966.4.camel@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 26 Mar 2018 18:42:44 +0300
Message-ID: <CABBYNZJSe0Me7hXYGyBEAMFmcEAoxCdjrJpTk_E5A-0LjOXszQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] mesh/meshctl: Exit cleanly if start up fails
To: "Stotland, Inga" <inga.stotland@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

On Mon, Mar 26, 2018 at 6:23 PM, Stotland, Inga <inga.stotland@intel.com> wrote:
> Hi Luiz,
>
> On Mon, 2018-03-26 at 16:31 +0300, Luiz Augusto von Dentz wrote:
>> Hi Inga,
>>
>> On Sat, Mar 24, 2018 at 4:33 AM, Inga Stotland <inga.stotland@intel.c
>> om> wrote:
>> > When failing to start meshctl due to invalid input configuration,
>> > release bt_shell resources prior to exit.
>>
>>
>> Similar response as to Eramoto's patch, if the tool is going to exit
>> there is no need to free up the resources, the exit status is still
>> useful but that is a different matter. Or perhaps we just want to
>> avoid false positives with static analyzers?
>>
>
> My motivation for this patch was quite simple: if the program exits
> after bt_shell_init() has ben called but prior to calling bt_shell_run,
> bash shell is all messed up (at least on my system) after that.

Then Im fine with the changes, but lets add this to the commit message
so it is clearer why we need to cleanup since it may affect the
original shell.

>>
>> > ---
>> >  mesh/main.c | 14 +++++++++-----
>> >  1 file changed, 9 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/mesh/main.c b/mesh/main.c
>> > index d991c9f8c..d0f71c2d9 100644
>> > --- a/mesh/main.c
>> > +++ b/mesh/main.c
>> > @@ -1930,11 +1930,11 @@ int main(int argc, char *argv[])
>> >         mesh_local_config_filename = g_malloc(len +
>> > strlen("local_node.json")
>> >
>> >      + 2);
>> >         if (!mesh_local_config_filename)
>> > -               exit(1);
>> > +               goto fail;
>> >
>> >         mesh_prov_db_filename = g_malloc(len +
>> > strlen("prov_db.json") + 2);
>> >         if (!mesh_prov_db_filename) {
>> > -               exit(1);
>> > +               goto fail;
>> >         }
>> >
>> >         sprintf(mesh_local_config_filename, "%s", mesh_config_dir);
>> > @@ -1950,7 +1950,7 @@ int main(int argc, char *argv[])
>> >         if (!prov_db_read_local_node(mesh_local_config_filename,
>> > true)) {
>> >                 g_printerr("Failed to parse local node
>> > configuration file %s\n",
>> >                         mesh_local_config_filename);
>> > -               exit(1);
>> > +               goto fail;
>> >         }
>> >
>> >         sprintf(mesh_prov_db_filename, "%s", mesh_config_dir);
>> > @@ -1965,7 +1965,7 @@ int main(int argc, char *argv[])
>> >         if (!prov_db_read(mesh_prov_db_filename)) {
>> >                 g_printerr("Failed to parse provisioning database
>> > file %s\n",
>> >                         mesh_prov_db_filename);
>> > -               exit(1);
>> > +               goto fail;
>> >         }
>> >
>> >         dbus_conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
>> > @@ -2001,5 +2001,9 @@ int main(int argc, char *argv[])
>> >         g_list_free(service_list);
>> >         g_list_free_full(ctrl_list, proxy_leak);
>> >
>> > -       return 0;
>> > +       return EXIT_SUCCESS;
>> > +
>> > +fail:
>> > +       bt_shell_cleanup();
>> > +       return EXIT_FAILURE;
>> >  }
>> > --
>> > 2.13.6
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-
>> > bluetooth" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>



-- 
Luiz Augusto von Dentz
